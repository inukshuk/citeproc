module CiteProc
	
	# Items are similar to a Ruby Hash but pose a number of constraints on their
	# contents: keys are always (implicitly converted to) symbols and values
	# are strictly instances of CiteProc::Variable. When Items are constructed
	# from (or merged with) JSON objects or Hashes Variable instances are
	# automatically created using by passing the variables key as type to
	# Variable.create – this will create the expected Variable type for all
	# fields defined in CSL (for example, the `issued' field will become a
	# CiteProc::Date object); unknown types will be converted to simple
	# CiteProc::Variable instances, which should be fine for numeric or string
	# values but may cause problems for more complex types.
	#
	# Every Item provides accessor methods for all known field names; unknown
	# fields can still be accessed using array accessor syntax.
	#
	#     i = Item.new(:edition => 3, :unknown_field => 42)
	#     i.edition         -> #<CiteProc::Number "3">
	#     i[:edition]       -> #<CiteProc::Number "3">
	#     i[:unknown_field] -> #<CiteProc::Variable "42">
	#
	# Items can be converted to the CiteProc JSON format via #to_citeproc (or
	# #to_json to get a JSON string).
	class Item
		
		include Attributes
		include Enumerable
		
		attr_predicates :id, *Variable.fields[:all]
		
		def initialize(attributes = nil)
			merge(attributes)
		end
		
		def initialize_copy(other)
			@attributes = other.attributes.deep_copy
		end
    
		# Don't expose attributes. Items need to mimic Hash functionality in a controlled way.
		private :attributes

		def [](key)
			return nil unless key.respond_to?(:to_sym)
			attributes[key.to_sym]
		end

		def []=(key, value)
			attributes[key.to_sym] = Variable.create(value, key.to_sym)
		end
		
		def each
			if block_given?
				attributes.each(&Proc.new)
				self
			else
				to_enum
			end
		end
		
		def to_citeproc
			Hash[*attributes.map { |k,v|
				[k.to_s, v.respond_to?(:to_citeproc) ? v.to_citeproc : v.to_s]
			}.flatten]
		end
		
		def to_json
			MultiJson.encode(to_citeproc)
		end
		
		private

		def filter_value(value, key)
			Variable.create!(value, key)
		end

	end

end