module CiteProc
	
	class Name
		
		extend Forwardable
		
		include Attributes
		include Comparable
		
		# Based on the regular expression in Frank G. Bennett's citeproc-js
		# https://bitbucket.org/fbennett/citeproc-js/overview
    ROMANESQUE =
			/^[a-zA-Z\u0080-\u017f\u0400-\u052f\u0386-\u03fb\u1f00-\u1ffe\.,\s\u0027\u02bc\u2019-]*$/


    # Class instance variables

		# Default formatting options
		@defaults = {
			:form => 'long',
			:'name-as-sort-order' => false,
			:'demote-non-dropping-particle' => 'display-and-sort',
			:'sort-separator' => ', ',
			:'initialize-with' => nil
		}.freeze
    
		@parts = [:family, :given,:literal, :suffix, :'dropping-particle',
			:'non-dropping-particle'].freeze
			
		class << self
			
			attr_reader :defaults, :parts
			
			def parse(name_string)
				parse!(name_string)
			rescue ParseError
				nil
			end
			
			def parse!(name_string)
			end
			
		end



		# Method generators
		
		attr_reader :options
		
		attr_predicates :'comma-suffix', :'static-ordering', *@parts
		
		# Aliases
		[[:last, :family], [:first, :given], [:particle, :'non_dropping_particle']].each do |a, m|
      alias_method(a, m) if method_defined?(m)

			wa, wm = "#{a}=", "#{m}="
      alias_method(wa, wm) if method_defined?(wm)

			pa, pm = "#{a}?", "#{m}?"
      alias_method(pa, pm) if method_defined?(pm)

			pa, pm = "has_#{a}?", "has_#{m}?"
      alias_method(pa, pm) if method_defined?(pm)
    end
	
		# Names quack sorta like a String
		def_delegators :to_s, :=~, :===,
			*String.instance_methods(false).reject { |m| m =~ /^\W|!$|to_s|replace|first|last/ }
		
		# Delegate bang! methods to each field's value
		String.instance_methods(false).each do |m|
			if m.to_s.end_with?('!')
				define_method(m) do |*arguments, &block|
					Name.parts.each do |part|
						attributes.fetch(part, '').send(m, *arguments, &block)
					end
					self
				end
			end
		end
		
		
		# Instance methods
		
		def initialize(attributes = {}, options = {})
			@options = Name.defaults.merge(options)			
			merge(attributes)
		end
		
		def initialize_copy(other)
			@attributes = other.attributes.deep_copy
			@options = other.options.dup
		end
		
		
		# Returns true if the Name looks like it belongs to a person.
		def personal?
			!!family && !literal?
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

		# Returns true if this Name's sort-oder options currently set.
		def sort_order?
			!!options[:'name-as-sort-order']
		end
		
		def display_order?
			!sort_order?
		end
		
		# Sets this name sort-order option to true. Returns the Name instance.
		def sort_order!
			options[:'name-as-sort-order'] = true
			self
		end
    
		# The reverse of @sort_order!
		def display_order!
			options[:'name-as-sort-order'] = false
			self
		end
		
		def sort_separator
			options[:'sort-separator']
		end
		
		alias comma sort_separator
		
		def short_form?
			options[:form] == 'short'
		end

		def short_form!
			options[:form] = 'short'
			self
		end

		def long_form!
			options[:form] = 'long'
			self
		end
		
		def initials?
			!!options[:'initialize-with'] && personal? && romanesque?
		end
		
		def demote_non_dropping_particle?
			flag = options[:'demote-non-dropping-particle']
			flag == 'display-and-sort' || sort_order? && flag == 'sort-only'
		end
		
		def <=>(other)
			return nil unless other.respond_to?(:sort_order)
			sort_order <=> other.sort_order
		end
		
		def to_citeproc
			attributes.stringify_keys
		end
		
		def display_order
			case
			when literal?
				literal.to_s
			
			when static_order?
				[family, given].compact.join(' ')
				
			when !short_form?
				case
				when !sort_order?
					[[given, dropping_particle, non_dropping_particle, family].compact_join(' '),
						suffix].compact_join(comma_suffix? ? comma : ' ')
					
				when !demote_non_dropping_particle
					[[non-dropping-particle, family].compact_join(' '), [given,
							dropping_particle].compact_join(' '), suffix].compact_join(comma)
					
				else
					[family, [given, dropping_particle, non_dropping_particle].compact.join(' '),
						suffix].compact_join(comma)
				end
				
			else
				[don_dropping_particle, family].compact_join(' ')
			end
		end
		
		def sort_order
			case
			when literal?
				literal.to_s
			else
				[family, given].compact.join(sort_separator)
			end
		end
		
		def to_s
			sort_order? ? sort_order : display_order
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
		
		def replace(names)
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
