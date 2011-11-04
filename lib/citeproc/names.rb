module CiteProc
	
	# Names consist of several dependent parts of strings. Simple personal names
	# are composed of family and given elements, containing respectively the
	# family and given name of the individual.
	#
	#		 Name.new(:family => 'Doe', :given => 'Jane')
	#
	# Institutional and other names that should always be presented literally
	# (such as "The Artist Formerly Known as Prince", "Banksy", or "Ramses IV")
	# should be delivered as a single :literal element:
	#
	#		 Name.new(:literal => 'Banksy')
	#
	# Name particles, such as the "von" in "Alexander von Humboldt", can be
	# delivered separately from the family and given name, as :dropping-particle
	# and :non-dropping-particle elements.
	#
	# Name suffixes such as the "Jr." in "Frank Bennett, Jr." and the "III" in
	# "Horatio Ramses III" can be delivered as a suffix element.
	#
	#		 Name.new do |n|
	#			 n.family, n.given, n.suffix = 'Ramses', 'Horatio', 'III'
	#		 end
	#
	# Names not written in the Latin or Cyrillic scripts are always displayed
	# with the family name first. Sometimes it might be desired to handle a
	# Latin or Cyrillic transliteration as if it were a fixed (non-Byzantine)
	# name. This behavior can be prompted by including activating
	# static-ordering:
	#
	#    Name.new(:family => 'Muramaki', :given => 'Haruki').to_s
	#      #=> "Haruki Muramaki"
	#    Name.new(:family => 'Muramaki', :given => 'Haruki').static_order!.to_s
	#      #=> "Muramaki Haruki"
	#   
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
				fail 'not implemented yet'
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
			
			yield self if block_given?
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
			!!([given, family].join.gsub(Variable.markup, '') =~ ROMANESQUE)
		end
		
		alias byzantine? romanesque?
		
		def static_order?
			static_ordering? || !romanesque?
		end

		def static_order!
			self.static_ordering = true
			self
		end

		alias static_order static_ordering
		alias static_order= static_ordering=

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

		# Compares two names. The comparison is based on #sort_order_downcase.
		def <=>(other)
			return nil unless other.respond_to?(:sort_order_downcase)
			sort_order_downcase <=> other.sort_order_downcase
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
		
		def strip_markup
			gsub(Variable.markup, '')
		end
		
		def strip_markup!
			gsub!(Variable.markup, '')
		end
		
		# Returns the sort order array stripped off markup and downcased.
		def sort_order_downcase
			sort_order.map { |s| s.downcase.gsub(Variable.markup, '') }
		end
		
		def inspect
			"#<CiteProc::Name #{to_s.inspect}>"
		end
		
		private
		
		attr_reader :sort_prefix
						
	end
	
	
	

	# Names are a CiteProc Variable containing an ordered list of Name objects.
	#
	# Names can be formatted using CSL formatting options. The available options
	# and their default values are described below.
	#
	# * and: specifies the delimiter between the penultimate and the last name.
	#   Defaults to '&'.
	#
	# * delimiter: Soecifies the text string to seaparate the individual names.
	#   The default value is ', '.
	#
	# * delimiter-precedes-last: determines in which cases the delimiter used
	#   to delimit names is also used to separate the second to last and the
	#   last name in name lists. The possible values are: 'contextual' (default,
	#   the delimiter is only included for name lists with three or more names),
	#   'always', and 'never'.
	#
	# * et-al-min and et-al-use-first: Together, these attributes control et-al
	#   abbreviation. When the number of names in a name variable matches or
	#   exceeds the number set on et-al-min, the rendered name list is truncated
	#   at the number of names set on et-al-use-first. If truncation occurs, the
	#   "et-al" term is appended to the names rendered (see also Et-al). With a
	#   single name (et-al-use-first="1"), the "et-al" term is preceded by a
	#   space (e.g. "Doe et al."). With multiple names, the "et-al" term is
	#   preceded by the name delimiter (e.g. "Doe, Smith, et al.").
	#
	# * et-al-subsequent-min / et-al-subsequent-use-first: The (optional)
	#   et-al-min and et-al-use-first attributes take effect for all cites and
	#   bibliographic entries. With the et-al-subsequent-min and
	#   et-al-subsequent-use-first attributes divergent et-al abbreviation rules
	#   can be specified for subsequent cites (cites referencing earlier cited
	#   items).
	#
	class Names < Variable
		
		@defaults = {
			:and => '&',
			:delimiter => ', ',
			:'delimiter-precedes-last' => :contextual,
			:'et-al-min' => 5,
			:'et-al-use-first' => 3,
			:'et-al-subsequent-min' => 5,
			:'et-al-subsequent-use-first' => 3
		}.freeze
		
		class << self
			
			attr_reader :defaults
			
			def parse(names_string)
				parse!(names_string)
			rescue ParseError
				nil
			end
			
			def parse!(names_string)
				fail 'not implemented yet'
			end
			
		end
		
		
		include Enumerable

		attr_reader :options
		
		alias names value
		
		# Don't expose value/names writer
		undef_method :value=
		
		# Delegate bang! methods to each name
		Variable.instance_methods(false).each do |m|
			if m.to_s.end_with?('!')
				define_method(m) do |*arguments, &block|
					names.each do |name|
						name.send(m, *arguments, &block) if name.respond_to?(m)
					end
					self
				end
			end
		end
		
		# Names quack sorta like an Array
		def_delegators :names, :length, :empty?, :[]
		
		# Some delegators should return self
		[:push, :<<, :unshift].each do |m|
			define_method(m) do |*arguments, &block|
				names.send(m, *arguments, &block)
				self
			end
		end
		
						
		def initialize(*arguments)
			@options = Names.defaults.dup
			super(arguments.flatten(1))
		end
		
		def initialize_copy(other)
			@options, @value = other.options.dup, other.value.map(&:dup)
		end
		
		def replace(values)
			@value = []
			
			values.each do |value|
				case
				when value.is_a?(Name)
					@value << value
				
				when value.is_a?(Hash)
					@value << Name.new(value)
					
				when value.respond_to?(:to_s)
					@value << Name.parse!(value.to_s)
					
				else
					raise TypeError, "failed to create names from #{value.inspect}"				
				end
			end
			
			self
		end
		
		# Returns true if the Names, if printed, will be abbreviated.
		def abbreviate?
			length >= options[:'et-al-min'].to_i
		end
		
		# Returns true if the Names, if printed on subsequent cites, will be abbreviated.
		def abbreviate_subsequent?
			length >= options[:'et-al-subsequent-min'].to_i
		end
	
		def delimiter
			options[:delimiter]
		end
		
		def last_delimiter
			delimiter_precedes_last? ? [delimiter, connector].compact.join : connector
		end
		
		# Returns whether or not the delimiter will be inserted between the penultimate and the last name.
		def delimiter_precedes_last?
			case
			when delimiter_never_precedes_last?
				false	
			when delimiter_always_precedes_last?
				true
			else
				length > 2
			end
		end
		
		def delimiter_always_precedes_last?
			!!(options[:'delimiter-precedes-last'].to_s =~ /^always$/i)
		end

		def delimiter_always_precedes_last!
			options[:'delimiter-precedes-last'].to_s = :always
		end

		alias delimiter_precedes_last! delimiter_always_precedes_last!
		
		def delimiter_never_precedes_last?
			!!(options[:'delimiter-precedes-last'].to_s =~ /^never$/i)
		end

		def delimiter_never_precedes_last!
			options[:'delimiter-precedes-last'].to_s = :never
		end

		def delimiter_never_precedes_last?
			!!(options[:'delimiter-precedes-last'].to_s =~ /^contextual/i)
		end

		def delimiter_contextually_precedes_last!
			options[:'delimiter-precedes-last'].to_s = :contextual
		end

	
		
		# Returns the string used as connector between the penultimate and the last name.
		def connector
			options[:and]
		end
		
		# Names are not numeric
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
		
		def to_s
			if length < 2
				names.join(last_delimiter)
			else
				[names[0...-1].join(delimiter), names[-1]].join(last_delimiter)
			end
		end
		
		def to_citeproc
			names.map(&:to_citeproc)
		end
		
		def inspect
			"#<CiteProc::Names #{to_s}>"
		end
				
	end
	
end
