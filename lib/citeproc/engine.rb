
module CiteProc
  
  class Engine

    @subclasses ||= []

    class << self
      attr_reader :subclasses, :type, :version
      
      def inherited(subclass)
        subclasses << subclass
        subclass.public_class_method :new
      end

      # Returns the engine class for the given name or nil. If no suitable
      # class is found and a block is given, executes the block and returns
      # the result.
      def detect(name)
        subclasses.detect(block_given? ? Proc.new : nil) { |e| e.name == name }
      end
      
      # Loads the engine with the given name and returns the engine class.
      def detect!(name)
        load(name)
        block_given? ? detect(name, &Proc.new) : detect(name)
      end
      
      # Loads the engine by requiring the engine name.
      def load(name)
        require name.gsub(/-/,'/')
      rescue LoadError => e
        warn "failed to load #{name} engine: try to gem install #{name}"
      end
      
      # Returns a list of all available engine names.
      def available
        subclasses.map(&:engine_name)
      end
      
      def engine_name
        @name || name # returns class name as fallback
      end
      
      private :new
    end

    include Abbreviate
    
    attr_accessor :style, :locale
    
    def initialize(options = {})
      @options = options.deep_copy
    end

    [:name, :type, :version].each do |method_id|
      define_method(method_id) do
        self.class.send(method_id)
      end
    end
    
    def process
      raise NotImplementedByEngine
    end
    
    def append
      raise NotImplementedByEngine
    end
    
    alias append_citation_cluster append
    
    def process_citation_cluster
      raise NotImplementedByEngine
    end
        
    def make_bibliography
      raise NotImplementedByEngine
    end
    
    def update_items
      raise NotImplementedByEngine
    end
    
    def update_uncited_items
      raise NotImplementedByEngine
    end
            
  end
  
end
