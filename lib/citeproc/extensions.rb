
module CiteProc
  module Extensions
    
    module DeepCopy  
      def deep_copy
        Hash[*map { |k,v| [
          k.is_a?(Symbol) ? k : k.respond_to?(:deep_copy) ? k.deep_copy : k.clone,
          v.is_a?(Symbol) ? v : v.respond_to?(:deep_copy) ? v.deep_copy : v.clone
        ]}.flatten(1)]
      end
    end
   
    module DeepFetch     
      def deep_fetch(*arguments)
        arguments.reduce(self) { |s,a| s[a] } rescue nil
      end
      
      def [](*arguments)
        return super if arguments.length == 1
        deep_fetch(*arguments)
      end
      
    end
    
    # shamelessly copied from active_support
    module SymbolizeKeys
      def symbolize_keys
        inject({}) do |options, (key, value)|
          options[(key.to_sym rescue key) || key] = value
          options
        end
      end
      
      def symbolize_keys!
        replace(symbolize_keys)
      end

    end

		module StringifyKeys
	    def stringify_keys
	      inject({}) do |options, (key, value)|
	        options[(key.to_s rescue key) || key] = value
	        options
	      end
	    end
    
	    def stringify_keys!
	      replace(symbolize_keys)
	    end
		end
    
    module AliasMethods
      private
      def alias_methods(*arguments)
        raise ArgumentError, "wrong number of arguments (#{arguments.length} for 2 or more)" if arguments.length < 2
        method_id = arguments.shift
        arguments.each { |a| alias_method method_id, a }
      end
    end
  end
end

class Hash
  include CiteProc::Extensions::DeepCopy
  include CiteProc::Extensions::DeepFetch
  include CiteProc::Extensions::SymbolizeKeys unless Hash.instance_methods.include?(:symbolize_keys)
  include CiteProc::Extensions::StringifyKeys unless Hash.instance_methods.include?(:stringify_keys)
end

# module Kernel
#   include CiteProc::Extensions::AliasMethods
# end
