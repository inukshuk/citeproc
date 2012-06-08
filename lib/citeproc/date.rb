module CiteProc

  # Represents a {Variable} wrapping a date value.
  class Date < Variable

    # Represents the individual parts of a date (i.e., year, month, day).
    class DateParts < Struct.new(:year, :month, :day)
      extend Forwardable
      
      def_delegators :to_date, :strftime
      
      def initialize(*arguments)
        super(*arguments.map(&:to_i))
      end
      
      # @return [::Date] the date parts as a Ruby date object
      def to_date
        ::Date.new(*to_a.compact)
      end
      
      alias to_ruby to_date
      
      def to_citeproc
        to_a.compact
      end
      
      def to_s
        to_citeproc.to_s
      end

    end
    
    include Attributes

    alias attributes value
    private :value=
    

    # Date parsers (must respond to :parse)
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
    
    
    # Format string used for sorting dates
    @sort_order = "%04d%02d%02d-%04d%02d%02d".freeze
    
    class << self

      attr_reader :parsers, :sort_order
      
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
        
        # if we get here, all parsers failed
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

    def replace(value)
      case
      when value.is_a?(CiteProc::Date)
        initialize_copy(value)

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

      when value.respond_to?(:strftime)
        @value = { :'date-parts' => [DateParts.new(*value.strftime('%Y-%m-%d').split(/-/))] }

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
    
    def date_parts
      @value[:'date-parts'] ||= [DateParts.new]
    end

    alias parts date_parts
    alias parts= date_parts=

    def empty?
      parts.map(&:to_citeproc).flatten.compact.empty?
    end

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
      ::Date.new(*parts[0])
    end

    def start_date=(date)
      parts[0] = date.strftime('%Y-%m-%d').split(/-/).map(&:to_i)
    end

    def end_date=(date)
      parts[1] = date.nil? ? [0,0,0] : date.strftime('%Y-%m-%d').split(/-/).map(&:to_i)
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
      range? && parts[1].uniq == [0]
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

    # @return [Hash] a hash representation of the date.
    def to_citeproc
      cp = @value.stringify_keys
      
      if empty?
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

    def sort_order
      Date.sort_order % ((parts[0] + [0,0,0])[0,3] + ((parts[1] || []) + [0,0,0])[0,3])
    end

    def <=>(other)
      return nil unless other.is_a?(Date)
      [year, sort_order] <=> [other.year, other.sort_order]
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
