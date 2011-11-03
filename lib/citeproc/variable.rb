
module CiteProc
  
  #
  # A CiteProc Variable represents the content of a text, numeric, date, or
  # name variable.
  #
  class Variable

    extend Forwardable
    include Comparable
    
    @fields = Hash.new { |h,k| h.fetch(k.to_sym, nil) }.merge({
      :date => %w{
				accessed container event-date issued original-date submitted
			},

      :names => %w{
				author collection-editor composer container-author recipient editor
				editorial-director illustrator interviewer original-author translator
			},
      
			:number => %w{
				chapter-number collection-number edition issue number number-of-pages
				number-of-volumes volume				
			},
			
      :text => %w{
				abstract annote archive archive_location archive-place authority
				call-number citation-label citation-number collection-title
				container-title container-title-short dimensions DOI event event-place
				first-reference-note-number genre ISBN ISSN jurisdiction keyword
				locator medium note original-publisher original-publisher-place
				original-title page page-first PMID PMCID publisher publisher-place
				references section source status title title-short URL version
				year-suffix
			}
    })
    
    @fields.each_value { |v| v.map!(&:to_sym) }
    
    @types = Hash.new { |h,k| h.fetch(k.to_sym, nil) }.merge(
      Hash[*@fields.keys.map { |k| @fields[k].map { |n| [n,k] } }.flatten]
    ).freeze
    
    @fields[:name] = @fields[:names]
    @fields[:dates] = @fields[:date]
    @fields[:numbers] = @fields[:number]
    
    @fields[:all] = @fields[:any] =
      [:date,:names,:text,:number].reduce([]) { |s,a| s.concat(@fields[a]) }.sort

    @fields.freeze

		@markup = /<[^>]*>/.freeze
		
		
    class << self
      attr_reader :fields, :types, :markup
      
      def create(value)
				new(value)
      end

    end
    
    attr_accessor :value

    def_delegators :@value, :to_s,
			*::String.instance_methods(false).select {|m| m.to_s =~ /!$/ }
    
    def_delegators :to_s, :=~, :===,
			*::String.instance_methods(false).reject {|m| m.to_s =~ /^\W|!$|to_s/ }

    def initialize(value = nil)
      replace(value)
      yield self if block_given?
    end
    
    def initialize_copy(other)
      @value = other.value.dup
    end
    

		# The replace method is typically called by the Variable's constructor. It
		# will try to set the Variable to the passed in value and should accept
		# a wide range of argument types; subclasses (especially Date and Names)
		# override this method.
		def replace(value)
			case value
			when NilClass, FalseClass, TrueClass, String, Symbol, Numeric, Variable
				@value = value.to_s
				self
			else
				raise TypeError, "failed to set date variable to #{value.inspect}"
			end
		end

		def type
			@type ||= self.class.name.split(/::/)[-1].downcase.to_sym
		end

		# Returns true if the Variable can be (safely) cast to a numeric value.
    def numeric?
      match(/\d/) ? to_i : false
    end
    
    # Returns (first) numeric data contained in the variable's value
    def to_i
     to_s =~ /(-?\d+)/ && $1.to_i || 0
    end
    
    def to_f
      to_s =~ /(-?\d[\d,\.]*)/ && $1.tr(',','.').to_f || 0.0
    end
    
    def strip_markup
      gsub(Variable.markup, '')
    end
    
    def strip_markup!
      gsub!(Variable.markup, '')
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
    
		alias to_citeproc value
		
    def to_json
      MultiJson.encode(to_citeproc)
    end

		def inspect
			"#<#{self.class.name}: #{to_s.inspect}>"
		end
		
  end


	class Text < Variable
	end

	class Number < Variable
	end

end