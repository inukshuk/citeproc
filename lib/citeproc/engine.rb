
module CiteProc
  
  class Engine
    
    include Abbreviate
    
    class << self

      def inherited(subclass)
        subclasses << subclass
      end
      
      def subclasses
        @subclasses ||= []
      end
      
      def detect
      end
    end
    
    attr_reader :options, :name, :version
    
    def initialize(options = {})
      @abbreviations = { :default => {} }
    end
    
    def process
    end
    
    def append
    end
    
    alias append_citation_cluster append
    
    def process_citation_cluster
    end
        
    def make_bibliography
    end
    
    def update_items
    end
    
    def update_uncited_items
    end
            
  end
  
end
