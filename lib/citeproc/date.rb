module CiteProc

  # Represents a {Variable} wrapping a date value. A date value is a hybrid
  # object in that it can represent either an atomic date or a date range,
  # depending on whether or not the 'date-parts' attribute contains one
  # or two lists of date parts.
  #
  # {Date Dates} can be constructed from a wide range of input values,
  # including Ruby date objects, integers, date ranges, ISO 8601 and
  # CiteProc JSON strings or hashes, and - provided you have the EDTF gem
  # installed - EDTF strings.
  #
  # @example Initialization
  #   CiteProc::Date.new
  #   #-> #<CiteProc::Date "[]">
  #
  #   CiteProc::Date.today
  #   #-> #<CiteProc::Date "[2012, 6, 10]">
  #
  #   CiteProc::Date.new(1966)
  #   #-> #<CiteProc::Date "[1966]">
  #
  #   CiteProc::Date.new(1999..2003)
  #   #-> #<CiteProc::Date "[[1999], [2003]]">
  #
  #   CiteProc::Date.new(Date.new(1900)...Date.new(2000))
  #   #-> #<CiteProc::Date "[[1900, 1, 1], [1999, 12, 31]]">
  #
  #   CiteProc::Date.new('2009-03?')
  #   #-> #<CiteProc::Date "[[2009, 3]]">
  #
  #   CiteProc::Date.new('2001-02/2007')
  #   #-> #<CiteProc::Date "[[2001, 2, 1], [2007, 12, 31]]">
  #
  # {Date} instances are typically manipulated by a cite processor. Therefore,
  # the API is optimized for easy information extraction and formatting.
  # Additionally, {Date Dates} can be serialized as CiteProc JSON data.
  #
  # @example Serialization
  #   CiteProc::Date.new('2009-03?').to_citeproc
  #   #-> {"date-parts"=>[[2009, 3]], "circa"=>true}
  #
  #   CiteProc::Date.new(1999..2003).to_json
  #   #-> '{"date-parts":[[1999],[2003]]}'
  #
  class Date < Variable


    # Represents the individual parts of a date (i.e., year, month, day).
    # There is a sublte difference between CiteProc dates (and date parts)
    # and regular Ruby dates, because a Ruby date will always contain valid
    # year, month and date values, whereas CiteProc dates may leave the month
    # and day parts empty. That is to say, CiteProc distinguishes between
    # the first of May 1955 and the month of May 1955 - a distinction that
    # is not supported by regular Ruby dates.
    #
    #     may_1955 = CiteProc::Date::DateParts.new(1955, 5)
    #     first_of_may_1955 = CiteProc::Date::DateParts.new(1955, 5, 1)
    #
    #     may_1955 < first_of_may_1955
    #     #-> true
    #
    #     Date.new(1955, 5) < Date.new(1955, 5, 1)
    #     #-> false
    #
    # The above example shows that a month's sort order is less than a day
    # in that month, whereas, with Ruby date's there is no such distinction.
    #
    # The {DateParts} class encapsulates the year, month and day parts of a
    # date; it is used internally by {Date} variables and not supposed to
    # be used in an external context.
    DateParts = Struct.new(:year, :month, :day) do
      include Comparable

      def initialize(*arguments)
        if arguments.length == 1 && arguments[0].is_a?(::Date)
          d = arguments[0]
          super(d.year, d.month, d.day)
        else
          super(*arguments.map { |value| to_part(value) })
        end
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
          self[part] = to_part(value)
        end

        self
      end

      # @return [Integer, nil] the value as a date part; empty values are unset
      def to_part(value)
        value.to_i unless value.to_s.strip.empty?
      end
      private :to_part

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
      # @return [Boolean] whether or not the date is BC
      def bc?
        !!(year && year < 0)
      end

      # A date is said to be AD when it is in the first millennium, i.e.,
      # between 1 and 1000 AD
      # @return [Boolean] whether or not the date is AD
      def ad?
        !bc? && year < 1000
      end

      # Seasons may be encoded as months 21 to 24 (Spring to Winter)
      # and, as citeproc-js does, 13 to 20 (Spring to Winter, twice).
      # @return [Integer, nil] the season (1 to 4) or nil if the
      #   month does not encode a season
      def season
        (month - 13) % 4 + 1 if month && month.between?(13, 24)
      end

      # @return [Boolean] whether or not the month encodes a season
      def season?
        !season.nil?
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
        when other.is_a?(DateParts) && season? && other.season?
          [year, season] <=> [other.year, other.season]
        when other.is_a?(DateParts)
          comparable <=> other.comparable
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
        to_citeproc.inspect
      end

      # @return [String] a human-readable representation of the object
      def inspect
        "#<DateParts #{to_s}>"
      end

      protected

      # Seasons are compared like dates without month.
      # @return [Array<Fixnum>] the date parts used for comparison
      def comparable
        season? ? to_citeproc.take(1) : to_citeproc
      end
    end

    #
    # CiteProc::Date
    #

    include Attributes


    alias attributes value
    protected :value, :attributes

    undef_method :value=


    # List of date parsers (must respond to #parse)
    @parsers = []

    begin
      require 'edtf'
      @parsers << ::EDTF
    rescue LoadError
      # warn "failed to load `edtf' gem"
    end

    @parsers << ::Date


    class << self

      # @!attribute [r] parsers
      #
      # A list of available date parsers. Each parser must respond to a
      # #parse method that converts a date string into a Ruby date object.
      # By default, the list will include Ruby's date parser from the
      # standard library, as well as the parser of the EDTF gem if it is
      # available; to install it on your system run `gem install edtf`.
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
      # @return [CiteProc::Date] the parsed date
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


    def_delegators :to_ruby, :strftime

    attr_predicates :circa, :literal, :'date-parts'

    # @return [Boolean] whether or not the date has a season field
    def has_season?
      attribute?(:season)
    end

    def season=(season)
      write_attribute :season, season
    end

    # Season names recognized in the season field
    SEASONS = {
      'spring' => 1, 'summer' => 2, 'autumn' => 3, 'fall' => 3, 'winter' => 4
    }.freeze

    # A season takes the place of the month. If the (start) date has a
    # month, the season is encoded by the month (21 to 24); otherwise
    # the season field is used. Season numbers (1 to 4) and names in
    # the season field are converted to integers.
    #
    # @return [Integer, String, nil] the season (1 to 4), the season
    #   field as a string if it is not a season number or name, or nil
    def season
      return parts[0].season if month

      value = read_attribute(:season) or return
      name = value.to_s.strip.downcase

      SEASONS[name] || (name.match?(/\A[1-4]\z/) ? name.to_i : value.to_s)
    end

    # @return [Boolean] whether or not the date has a season (see #season)
    def season?
      !season.nil?
    end

    def initialize(value = {})
      super
      yield self if block_given?
    end

    def initialize_copy(other)
      @value = other.value.deep_copy
    end

    def marshal_dump
      to_citeproc
    end

    def marshal_load(value)
      replace(value)
    end

    def merge(other)
      super
      convert_parts!
    end

    # Replaces the date's value. Typically called by the constructor, this
    # method intelligently converts various input values.
    def replace(value)
      case
      when value.is_a?(CiteProc::Date)
        initialize_copy(value)
      when value.is_a?(::Date) && Object.const_defined?(:EDTF)
        @value = { :'date-parts' => [DateParts.new(*value.values)] }
        uncertain! if value.uncertain?
      when value.respond_to?(:strftime)
        @value = { :'date-parts' => [DateParts.new(*value.strftime('%Y-%m-%d').split(/-/))] }
      when value.is_a?(Numeric)
        @value = { :'date-parts' => [DateParts.new(value)] }
      when value.is_a?(Hash)
        attributes = value.symbolize_keys

        if attributes.has_key?(:raw) && Array(attributes[:'date-parts']).empty?
          raw = attributes.delete(:raw)
          attributes.delete(:'date-parts')
          date = Date.parse(raw)

          @value = date.nil? ? { :literal => raw } : date.value
          @value.merge!(attributes)
        else
          @value = attributes.except(:raw).deep_copy
        end
        convert_parts!

      when value.is_a?(Array)
        @value = { :'date-parts' => value[0].is_a?(Array) ? value : [value] }
        convert_parts!
      when !value.is_a?(String) && value.respond_to?(:min) && value.respond_to?(:max)
        @value = { :'date-parts' => [
            DateParts.new(value.min),
            DateParts.new(value.max)
          ]}
      when value.is_a?(String) && /^\s*\{/ =~ value
        return replace(::JSON.parse(value, :symbolize_names => true))
      when value.respond_to?(:to_s)
        @value = Date.parse!(value.to_s).value
      else
        raise TypeError, "failed to create date from #{value.inspect}"
      end

      self
    end

    remove_method :date_parts

    # @return [Array<DateParts>]
    def date_parts
      value[:'date-parts'] ||= []
    end

    alias parts  date_parts
    alias parts= date_parts=

    # @return [Boolean] whether or not the date parts' are empty and the
    #   date is neither literal nor a season
    def empty?
      parts.all?(&:empty?) && !literal? && !season?
    end

    # @return [true] dates are dates
    def date?
      true
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
        d = parts[0] and d.send(reader)
      end

      define_method(writer) do |v|
        parts[0] ||= DateParts.new
        parts[0].send(writer, v.to_i)
      end
    end

    # @return [Date] a copy of the date with an inverted year
    def -@
      d = dup
      d.year = -1 * year
      d
    end

    # @return [::Date, Range, nil] the date as a Ruby date object or as
    #   a Range if this instance is closed range
    def to_ruby
      if closed_range?
        parts[0].to_date..parts[1].to_date
      else
        d = parts[0] and d.to_date
      end
    end

    # @return [Boolean] whether or not the date-parts contain an end date
    def has_end_date?
      parts[1] && !parts[1].empty?
    end

    alias range? has_end_date?
		alias plural? has_end_date?

    # @return [Boolean] whether or not this date is an open range
    def open_range?
      range? && parts[1].open?
    end

    alias open? open_range?

    # @return [Boolean] whether or not this date is a closed range
    def closed_range?
      range? && !open_range?
    end

    alias closed? closed_range?

    alias uncertain? circa?

    # Marks the date as uncertain
    # @return [self]
    def uncertain!
      value[:circa] = true
      self
    end

    # Marks the date as a certain date
    # @return [self]
    def certain!
      value[:circa] = false
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
      cp = value.stringify_keys

      # Convert (or suppress empty) date-parts
      if parts.all?(&:empty?)
        cp.delete('date-parts')
      else
        cp['date-parts'] = cp['date-parts'].map(&:to_citeproc)
      end

      cp
    end

    # @return [String] the date as a string
    def to_s
      case
      when literal?
        literal
      when has_season?
        season
      else
        parts.map(&:to_citeproc).inspect
      end
    end

    def <=>(other)
      case other
      when CiteProc::Date
        result = parts <=> other.parts

        # Seasons are ordered among themselves only
        if result == 0 && season? && other.season?
          result = season.to_i <=> other.season.to_i
        end

        result
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
