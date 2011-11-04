module CiteProc
	
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
				
    def merge(other)
      return self if other.nil?
      
      case other
      when String, /^\s*\{/
        other = MulitJson.decode(other, :symbolize_keys => true)
      when Hash
				# do nothing
      when Attributes
        other = other.to_hash
			else
				raise ParseError, "failed to merge item and #{other.inspect}"
      end

      other.each_pair do |key, value|
				key = key.to_sym
				attributes[key] = Variable.create!(value, key)
			end
      
      self
    end
    
		# Don't expose attributes. Items need to mimic Hash functionality in a controlled way.
		private_methods :attributes

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
		
	end
	
end