
require 'date'

begin
  require 'chronic'
rescue LoadError => e
  # warn 'failed to load chronic gem'
end

module CiteProc

  class Date < Variable

    include Attributes

    alias attributes value
    alias to_hash value
    
    @parser = Object.const_defined?(:Chronic) ? ::Chronic : ::Date
    
    class << self

      def parse(date_string)
        new(@parser.parse(date_string))
      rescue => e
        raise ArgumentError.new("failed to parse date from #{date_string.inspect}", e)
      end
      
      def today
        new(::Date.today)
      end
      
      alias now today
      
    end
    

    def initialize(attributes = ::Date.today)
      super
    end
    
    def initialize_copy(other)
      @value = other.value.deep_copy
    end
    
    def parse(attributes)
      case
      when attributes.is_a?(Date)
        @value = attributes.dup

      when attributes.is_a?(Numeric)
        @value = { :'date-parts' => [[attributes.to_i]] }
        
      when attributes.is_a?(Hash)
        attributes = attributes.symbolize_keys
        if attributes.has_key?(:raw)
          @value = Date.parse(attributes.delete(:raw)).value
          @value.merge!(attributes)
        else
          @value = attributes.deep_copy
        end
        to_i!
        
      when attributes.respond_to?(:strftime)
        @value = { :'date-parts' => [attributes.strftime('%Y-%m-%d').split(/-/).map(&:to_i)] }
        
      when attributes.is_a?(Array)
        @value = { :'date-parts' => attributes[0].is_a?(Array) ? attributes : [attributes] }
        to_i!
        
      when attributes.respond_to?(:to_s)
        @value = Date.parse(attributes.to_s).value
        
      else
        raise ArgumentError, "failed to parse date from #{attributes.inspect}"
      end
    end

    attr_predicates :circa, :season, :literal, :'date-parts'

    def date_parts
      @value[:'date-parts'] ||= [[]]
    end
    
    alias parts date_parts
    alias parts= date_parts=

    %w{ year month day }.each_with_index do |m,i|
      define_method(m) { parts[0][i] }
      define_method("#{m}=") { |v| parts[0][i] = v.to_i }
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
    
    # Returns a Ruby date object for this instance, or Range object if this
    # instance is closed range
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

    def closed_range?
      range? && !open_range?
    end

    alias uncertain? circa?
        
    # Marks the date as uncertain
    def uncertain!; @value[:'circa'] = true; end
    
    # Marks the date as a certain date
    def certain!; @value[:'circa'] = false; end    

    def certain?; !uncertain?; end
        
    def numeric?; false; end
    
    def bc?; year && year < 0; end
    def ad?; !bc? && year < 1000; end
    
    def to_s
      literal? ? literal : @value.inspect
    end
    
    def sort_order
      "%04d%02d%02d-%04d%02d%02d" % ((parts[0] + [0,0,0])[0,3] + ((parts[1] || []) + [0,0,0])[0,3])
    end
        
    def <=>(other)
      return nil unless other.is_a?(Date)
      [year, sort_order] <=> [other.year, other.sort_order]
    end
    
    private
    
    def to_i!
      parts.each { |p| p.map!(&:to_i) }
    end
    
  end
  
end
