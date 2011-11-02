module CiteProc
	
	class Name
		
		extend Forwardable
		
		include Attributes
		include Comparable
		
		# Based on the regular expression in Frank G. Bennett's citeproc-js
		# https://bitbucket.org/fbennett/citeproc-js/overview
    ROMANESQUE = /^[a-zA-Z\u0080-\u017f\u0400-\u052f\u0386-\u03fb\u1f00-\u1ffe\.,\s\u0027\u02bc\u2019-]*$/
    
		attr_fields :family, :given, :literal, :'dropping-particle', 
			:'non-dropping-particle', :suffix
			
		attr_predicates :'comma-suffix', :'static-ordering'
		
		[[:last, :family], [:first, :given]].each do |a, m|
      alias_method a, m
			alias_method "#{a}=", "#{m}="
    end
    
		@defaults = {
			:form => 'long',
			:'name-as-sort-order' => false,
			:'demote-non-dropping-particle' => 'display-and-sort',
			:'sort-separator' => ', ',
			:'initialize-with' => nil
		}.freeze
    
		class << self
			
			attr_reader :defaults
			
			def parse(name_string)
			end
			
		end
		
		attr_reader :options
		
		# Names quack sorta like a String
		def_delegators :to_s, :=~, :===,
			*String.instance_methods(false).reject { |m| m =~ /^\W|!$|replace|first|last/ }
		
		# Delegate bang methods to each field's value
		String.instance_methods(false).each do |m|
			if m.to_s.end_with?('!')
				define_method(m) { attributes.values.each(&m.to_sym) }
			end
		end
		
		def initialize
			@options = Name.defaults.merge({})
		end
		
		def initialize_copy(other)
			@attributes = other.attributes.deep_copy
			@options = other.options.dup
		end
		
		def personal?
			!!family
		end
		
		# Returns true if the name contains only romanesque characters. This
		# should be the case for the majority of names written in latin or
		# greek based script. It will be false, for example, for names written
		# in Chinese, Japanese, Arabic or Hebrew.
		def romanesque?
			[given, family].join =~ ROMANESQUE
		end
		
		alias byzantine? romanesque?
		
		def static_order?
			static_ordering? || !romanesque?
		end

		def sort_order?
			!!options[:'name-as-sort-order']
		end
    
		
		def initials
		end
		
		def <=>(other)
		end
		
		def to_citeproc
			attributes.stringify_keys
		end
		
		def inspect
			"#<CiteProc::Name #{to_s.inspect}>"
		end
		
	end
	
	class Names < Variable
		
		include Enumerable
				
		def initialize_copy(other)
			@value = other.value.map(&:dup)
		end
		
		def value
			@value ||= []
		end
		
		alias names value
		
		Variable.instance_methods(false).each do |m|
			if m.to_s.end_with?('!')
				define_method(m) { names.each(&m.to_sym) }
			end
		end
		
		def update(attributes)
		end
		
		def numeric?
			false
		end
		
		def each
			if block_given?
				names.each(&Proc.new)
				self
			else
				to_enum
			end
		end
		
		def <=>(other)
			return nil unless other.respond_to?(:names)
			names <=> other.names
		end
		
		def to_citeproc
			names.map(&:to_citeproc)
		end
		
	end
	
end
