module CiteProc

  # Represents a {Variable} wrapping a date value.
  class Date < Variable

    # Represents the individual parts of a date (i.e., year, month, day).
    class DateParts < Struct.new(:year, :month, :day)
      include Comparable
      
      def initialize(*arguments)
        super(*arguments.map(&:to_i))
      end
      
      def initialize_copy(other)
        update(other)
      end
      
      # Update the date parts with the passed-in values.
      # @param parts [Array, #each_pair] an ordered list of date parts (year,
      #   month, day) or a Hash containing the mapping
      # @return [self]
      def update(parts)
        unless parts.respond_to?(:each_pair)
          parts = Hash[DateParts.members.zip(parts)]
        end
        
        parts.each_pair do |part, value|
          self[part] = value.to_i
        end
        
        self
      end
      
      # @return [Boolean] whether or not the date parts are unset
      def empty?
        to_citeproc.empty?
      end

      # In the current CiteProc specification, date parts consisting of
      # zeroes are used to designate open ranges.
      # @return [Boolean] whether or not the this is an open-end date
      def open?
        to_citeproc.include?(0)
      end

      # A date is said to be BC when the year is defined and less than zero.
      # @return [true,false] whether or not the date is BC
      def bc?
        !!(year && year < 0)
      end

      # A date is said to be AD when it is in the first millennium, i.e.,
      # between 1 and 1000 AD
      # @return [true,false] whether or not the date is AD
      def ad?
        !bc? && year < 1000
      end

      # Formats the date parts according to the passed-in format string.
      # @param format [String] a format string
      # @return [String,nil] the formatted date string; nil if the date
      #   parts are not a valid date.
      def strftime(format = '%F')
        d = to_date
        
        if d.nil?
          nil
        else
          d.strftime(format)
        end
      end

      # Compares the date parts with the passed-in date.
      # @param other [DateParts, #to_date] the other date
      # @return [Fixnum,nil] the result of the comparison (-1, 0, 1 or nil)
      def <=>(other)
        case
        when other.is_a?(DateParts)
          to_citeproc <=> other.to_citeproc
        when other.respond_to?(:to_date)
          to_date <=> other.to_date
        else
          nil
        end
      end
           
      # Convert the date parts into a proper Ruby date object; if the date
      # parts are empty, contain zero or are otherwise invalid, nil will
      # be returned instead.
      # @return [::Date,nil] the date parts as a Ruby date object
      def to_date
        parts = to_citeproc
        
        if parts.empty? || parts.include?(0)
          nil
        else
          begin
            ::Date.new(*parts)
          rescue
            # Catch invalid dates (e.g., if the month is 13).
            nil
          end
        end
      end
      
      alias to_ruby to_date
      
      # @return [Array<Fixnum>] the list of date parts
      def to_citeproc
        take_while { |p| !p.nil? }
      end
      
      # @return [String] the date parts as a string
      def to_s
        to_citeproc.to_s
      end

      # @return [String] a human-readable representation of the object
      def inspect
        "#<DateParts #{to_s}>"
      end
    end
    

    include Attributes

    alias attributes value
    private :value=
    

    # List of date parsers (must respond to #parse)
    @parsers = []

    require 'date'
    @parsers << ::Date
    
    [%{ edtf EDTF }, %w{ chronic Chronic }].each do |date_parser, module_id|
      begin
        require date_parser
        @parsers << ::Object.const_get(module_id)
      rescue LoadError
        # warn "failed to load `#{date_parser}' gem"
      end
    end
    
    
    class << self

      # @!attribute [r] parsers
      #
      # A list of available date parsers. Each parser must respond to a
      # #parse method that converts a date string into a Ruby date object.
      # By default, the list will include Ruby's date parser from the
      # standard library, as well as the parsers of the Chronic and EDTF
      # gems if they are available; to install the latter on your system
      # make sure to `gem install chronic edtf`.
      #
      # @return [Array] the available date parsers
      attr_reader :parsers

      # Parses the passed-in string with all available date parsers. Creates
      # a new CiteProc Date from the first valid date returned by a parser;
      # returns nil if no parser was able to parse the string successfully.
      #
      # For an equivalent method that raises an error on invalid input
      # @see #parse!
      #
      # @param date_string [String] the date to be parsed
      # @return [CiteProc::Date,nil] the parsed date or nil
      def parse(date_string)
        parse!(date_string)
      rescue ParseError
        nil
      end
      
      # Like #parse but raises a ParseError if the input failed to be parsed.
      #
      # @param date_string [String] the date to be parsed
      # @return [CiteProc::Date,nil] the parsed date or nil
      #
      # @raise [ParseError] when the string cannot be parsed    
      def parse!(date_string)
        @parsers.each do |p|
          date = p.parse(date_string) rescue nil
          return new(date) unless date.nil?
        end
        
        # Subtle: if we get here it means all parsers failed to create a date
        raise ParseError, "failed to parse #{date_string.inspect}"
      end

      # @return [CiteProc::Date] a date object for the current day
      def today
        new(::Date.today)
      end

      alias now today

    end


    attr_predicates :circa, :season, :literal, :'date-parts'

    # Make Date behave like a regular Ruby Date
    def_delegators :to_ruby,
      *::Date.instance_methods(false).reject { |m| m.to_s =~ /^to_s$|^inspect$|start$|^\W/ }


    def initialize(value = ::Date.today)
      super
      yield self if block_given?
    end

    def initialize_copy(other)
      @value = other.value.deep_copy
    end

    def merge(other)
      super
      convert_parts!
    end
    
    def replace(value)
      case
      when value.is_a?(CiteProc::Date)
        initialize_copy(value)

      when value.respond_to?(:strftime)
        @value = { :'date-parts' => [DateParts.new(*value.strftime('%Y-%m-%d').split(/-/))] }
        uncertain! if value.respond_to?(:uncertain?) && value.uncertain?

      when value.is_a?(Numeric)
        @value = { :'date-parts' => [DateParts.new(value)] }

      when value.is_a?(Hash)
        attributes = value.symbolize_keys

        if attributes.has_key?(:raw)
          @value = Date.parse(attributes.delete(:raw)).value
          @value.merge!(attributes)
        else
          @value = attributes.deep_copy
        end
        convert_parts!

      when value.is_a?(Array)
        @value = { :'date-parts' => value[0].is_a?(Array) ? value : [value] }
        convert_parts!

      when value.respond_to?(:to_s)
        @value = Date.parse(value.to_s).value

      else
        raise TypeError, "failed to create date from #{value.inspect}"
      end

      self
    end
    
    # @return [Array<DateParts>]
    def date_parts
      @value[:'date-parts'] ||= []
    end

    alias parts  date_parts
    alias parts= date_parts=

    # @return [Boolean] whether or not the date parts' are empty
    def empty?
      parts.all?(&:empty?) && !literal? && !season?
    end

    # @!attribute year
    # @return [Fixnum] the year (of the start date for ranges)

    # @!attribute month
    # @return [Fixnum] the month (of the start date for ranges)

    # @!attribute day
    # @return [Fixnum] the day (of the start date for ranges)
    [:year, :month, :day].each do |reader|
      writer = "#{reader}="
      
      define_method(reader) do
        parts[0].send(reader)
      end
      
      define_method(writer) do |v|
        parts[0].send(writer, v.to_i)
      end
    end
    
    def -@
      d = dup
      d.year = -1 * year
      d
    end
    
    def start_date
      d = parts[0] and d.to_date
    end

    def start_date=(date)
      parts[0] = DateParts.new(date.strftime('%Y-%m-%d').split(/-/))
    end

    def end_date=(date)
      parts[1] = DateParts.new(date.nil? ? 0 : date.strftime('%Y-%m-%d').split(/-/))
    end

    # @return [Date,Range] the date as a Ruby date object or as a Range if
    #   this instance is closed range
    def to_ruby
      closed_range? ? start_date ... end_date : start_date
    end

    def end_date
      closed_range? ? ::Date.new(*parts[1]) : nil
    end

    def has_end_date?
      parts[1] && !parts[1].empty?
    end

    # Returns true if this date is a range
    alias range? has_end_date?

    def open_range?
      range? && parts[1].open?
    end

    alias open? open_range?

    def closed_range?
      range? && !open_range?
    end

    alias closed? closed_range?

    alias uncertain? circa?

    # Marks the date as uncertain
    # @return [self]
    def uncertain!
      @value[:circa] = true
      self
    end

    # Marks the date as a certain date
    # @return [self]
    def certain!
      @value[:circa] = false
      self
    end

    def certain?
      !uncertain?
    end

    # @return false
    def numeric?
      false
    end

    # A date is said to be BC when the year is defined and less than zero.
    # @return [Boolean, nil] whether or not the date is BC; nil if there is
    #   no start date set
    def bc?
      date = parts[0] and date.bc?
    end
    
    # A date is said to be AD when it is in the first millennium, i.e.,
    # between 1 and 1000 AD
    # @return [Boolean, nil] whether or not the date is AD; nil if there is
    #   no start date set
    def ad?
      date = parts[0] and date.ad?
    end

    # @return [Hash] a hash representation of the date.
    def to_citeproc
      cp = @value.stringify_keys
      
      if parts.all?(&:empty?)
        cp.delete('date-parts')
      else
        cp['date-parts'] = cp['date-parts'].map(&:to_citeproc)
      end
      
      cp
    end
    
    # @return [String] the date as a string
    def to_s
      literal? ? literal : to_ruby.to_s
    end

    def <=>(other)
      case other
      when Date
        parts <=> other.parts
      when ::Date
        parts <=> [other]
      else
        nil
      end
    end

    private

    def convert_parts!
      parts.map! do |part|
        part.is_a?(DateParts) ? part : DateParts.new(*part)
      end

      self
    end

  end

end
