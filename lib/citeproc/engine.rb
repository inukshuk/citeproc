
module CiteProc
  
  class Engine

    @subclasses ||= []

    class << self
      
      attr_reader :subclasses, :type, :version
   
      private :new
      
      def inherited(subclass)
        subclass.public_class_method :new
        @subclasses << subclass
        @subclasses = subclasses.sort_by { |engine| -1 * engine.priority }
      end

      # Returns the engine class for the given name or nil. If no suitable
      # class is found and a block is given, executes the block and returns
      # the result. The list of available engines will be passed to the block.
      def detect(name)
        subclasses.detect { |e| e.name == name } ||
          block_given? ? yield(subclasses) : nil
      end
      
      # Loads the engine with the given name and returns the engine class.
      def detect!(name)
        load(name)
        block_given? ? detect(name, &Proc.new) : detect(name)
      end
      
      # Returns the best available engine class or nil.
      def autodetect(options = {})
        return nil if subclasses.empty?
        
        klass = subclasses.detect { |e|
          !options.has_key?(:engine) || e.name == options[:engine] and
          !options.has_key?(:name) || e.name == options[:name]
        } || subclasses.first
        
        block_given? ? klass.new(&Proc.new) : klass.new
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
        @name ||= name.gsub(/::/, '-').downcase # returns class name as fallback
      end

      def priority
        @priority ||= 0
      end      
    end

    attr_accessor :processor, :locales, :style
    
    def initialize(attributes = {})
      @processor = attributes[:processor]
      yield self if block_given?
    end

    def start
      @started = true
    end
    
    def stop
      @started = false
    end
    
    def started?; !!@started; end
    
    alias running? started?
    
    [[:name, :engine_name], :type, :version].each do |method_id, target|
      define_method(method_id) do
        self.class.send(target || method_id)
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
