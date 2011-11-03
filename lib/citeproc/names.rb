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
			:'demote-non-dropping-particle' => 'never',
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
		
		attr_predicates :'comma-suffix', :'static-ordering', :multi, *@parts
		
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
						p = attributes[part]
						p.send(m, *arguments, &block) if p.respond_to?(m)
					end
					self
				end
			end
		end
		
		
		# Instance methods
		
		def initialize(attributes = {}, options = {})
			@options = Name.defaults.merge(options)
			@sort_prefix = (/^(the|an?|der|die|das|eine?|l[ae])\s+|^l\W/i).freeze
			
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
			!!(options[:'name-as-sort-order'].to_s =~ /^(y(es)?|always|t(rue)?)$/i)
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

		def long_form?
			options[:form] == 'long'
		end

		def long_form!
			options[:form] = 'long'
			self
		end

		# TODO should be done via mixin to be reused for variables
		# def transliterable?
		# end
		# 
		# def transliterate(locale)
		# end
		
		def initials?
			!!options[:'initialize-with'] && personal? && romanesque?
		end
		
		def demote_non_dropping_particle?
			always_demote_non_dropping_particle? ||
				!!(sort_order? && options[:'demote-non-dropping-particle'] =~ /^sort(-only)?$/i)
		end

		alias demote_particle? demote_non_dropping_particle?
		
		def never_demote_non_dropping_particle?
			!!(options[:'demote-non-dropping-particle'] =~ /^never$/i)
		end

		def never_demote_non_dropping_particle!
			options[:'demote-non-dropping-particle'] = 'never'
			self
		end

		alias never_demote_particle? never_demote_non_dropping_particle?
		alias never_demote_particle! never_demote_non_dropping_particle!

		def always_demote_non_dropping_particle?
			!!(options[:'demote-non-dropping-particle'] =~ /^(display-and-sort|always)$/i)
		end

		def always_demote_non_dropping_particle!
			options[:'demote-non-dropping-particle'] = 'display-and-sort'
			self
		end

		alias always_demote_particle? always_demote_non_dropping_particle?
		alias always_demote_particle! always_demote_non_dropping_particle!

		alias demote_particle! always_demote_non_dropping_particle!

		def <=>(other)
			return nil unless other.respond_to?(:sort_order)
			sort_order <=> other.sort_order
		end
		
		def to_citeproc
			attributes.stringify_keys
		end
		
		# Returns the Name as a String according to the Name's formatting options.
		def to_s
			case
			when literal?
				literal.to_s
			
			when static_order?
				[family, given].compact.join(' ')
				
			when !short_form?
				case
				when !sort_order?
					[[given, dropping_particle, particle, family].compact_join(' '),
						suffix].compact_join(comma_suffix? ? comma : ' ')
					
				when !demote_particle?
					[[particle, family].compact_join(' '), [given,
						dropping_particle].compact_join(' '), suffix].compact_join(comma)
					
				else
					[family, [given, dropping_particle, particle].compact_join(' '),
						suffix].compact_join(comma)
				end
				
			else
				[particle, family].compact_join(' ')
			end
		end
		
		# Returns an ordered array of formatted name parts to be used for sorting.
		def sort_order
			case
			when literal?
				[literal.to_s.sub(sort_prefix, '')]
			when never_demote_particle?
				[[particle, family].compact_join(' '), dropping_particle, given, suffix].map(&:to_s)
			else
				[family, [particle, dropping_particle].compact_join(' '), given, suffix].map(&:to_s)
			end
		end
		
		
		def inspect
			"#<CiteProc::Name #{to_s.inspect}>"
		end
		
		private
		
		attr_reader :sort_prefix
						
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
