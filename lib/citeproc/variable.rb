
module CiteProc
  
  #
  # A CiteProc Variable represents the content of a text, numeric, date, or
  # name variable.
  #
  class Variable

    extend Forwardable
    
    include Comparable
    
    @fields = Hash.new { |h,k| h.fetch(k.to_sym, nil) }.merge({
      :date => %w{ accessed container event-date issued original-date },
      
      :names => %w{
        author editor translator recipient interviewer publisher composer
        original-publisher original-author container-author collection-editor },
      
      :text => %w{
        id abstract annote archive archive-location archive-place authority
        call-number chapter-number citation-label citation-number collection-title
        container-title DOI edition event event-place first-reference-note-number
        genre ISBN issue jurisdiction keyword locator medium note number
        number-of-pages number-of-volumes original-publisher original-publisher-place
        original-title page page-first publisher publisher-place references
        section status title URL version volume year-suffix }
    })
    
    @fields.each_value { |v| v.map!(&:to_sym) }
    
    @types = Hash.new { |h,k| h.fetch(k.to_sym, nil) }.merge(
      Hash[*@fields.keys.map { |k| @fields[k].map { |n| [n,k] } }.flatten]
    ).freeze
    
    @fields[:name] = @fields[:names]
    @fields[:dates] = @fields[:date]
    
    @fields[:all] = @fields[:any] =
      [:date,:names,:text].reduce([]) { |s,a| s.concat(@fields[a]) }.sort

    @fields.freeze

    class << self
      attr_reader :fields, :types
      
      def parse(*args)
      end
    end
    
    def initialize(attributes = nil)
      parse(attributes)
      yield self if block_given?
    end
    
    def initialize_copy(other)
      @value = other.value.dup
    end
    
    attr_accessor :value

    def_delegators :@value, :to_s, :strip!, :upcase!, :downcase!, :sub!, :gsub!, :chop!, :chomp!, :rstrip!
    
    def_delegators :to_s, :empty?, :=~, :===, :match, :intern, :to_sym, :end_with?, :start_with?, :include?, :upcase, :downcase, :reverse, :chop, :chomp, :rstrip, :gsub, :sub, :size, :strip, :succ, :to_c, :to_r, :to_str, :split, :each_byte, :each_char, :each_line

    def parse(attributes)
      case
      when attributes.is_a?(Hash)
        attributes.each_key do |key|
          writer = "#{key}="
          send(writer, attributes[key]) if respond_to?(writer)
        end
      when attributes.respond_to?(:to_s)
        @value = attributes.to_s.dup
      end
    end
    
    def type
      @type ||= self.class.name.split(/::/)[-1].downcase.to_sym
    end
    
    def numeric?
      self =~ /\d/ ? to_i : false
    end
    
    # @returns (first) numeric data contained in the variable's value
    def to_i
      to_s =~ /(-?\d+)/ && $1.to_i || 0
    end
    
    def to_f
      to_s =~ /(-?\d[\d,\.]*)/ && $1.tr(',','.').to_f || 0.0
    end
    
    def strip_markup
      gsub(/<[^>]*>/, '')
    end
    
    def strip_markup!
      gsub!(/<[^>]*>/, '')
    end 
    
    def <=>(other)
      case
      when other.respond_to?(:strip_markup)
        strip_markup <=> other.strip_markup
      when other && other.respond_to?(:to_s)
        to_s <=> other.to_s
      else
        nil
      end
    end
    
    def to_json
      MultiJson.encode(@value)
    end
  end
  
  class Text < Variable; end
end