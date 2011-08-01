
module CiteProc
  module Extensions
    
    module DeepCopy  
      def deep_copy
        Hash[*map { |k,v| [
          k.is_a?(Symbol) ? k : k.respond_to?(:deep_copy) ? k.deep_copy : k.clone,
          v.is_a?(Symbol) ? v : v.respond_to?(:deep_copy) ? v.deep_copy : v.clone
        ]}.flatten]
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
end

# module Kernel
#   include CiteProc::Extensions::AliasMethods
# end
