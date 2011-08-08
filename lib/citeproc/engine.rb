require 'forwardable'

module CiteProc
  
  class Engine
    
    extend Forwardable
    include Abbreviate
    
    @subclasses ||= []

    class << self
            
      attr_reader :subclasses, :type, :version
   
      attr_writer :default
   
      private :new
      
      def inherited(subclass)
        subclass.public_class_method :new
        @subclasses << subclass
        @subclasses = subclasses.sort_by { |engine| -1 * engine.priority }
      end

      def default
        @default ||= autodetect or warn 'no citeproc engine found'
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
        klass = subclasses.detect { |e|
          !options.has_key?(:engine) || e.name == options[:engine] and
          !options.has_key?(:name) || e.name == options[:name]
        } || subclasses.first        
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

    def_delegators :@processor, :items, :options
    
    
    def initialize(attributes = {})
      @processor = attributes[:processor]
      @abbreviations = attributes[:abbreviations] || { :default => {} }
      yield self if block_given?
    end

    def start
      @started = true
      self
    end
    
    def stop
      @started = false
      self
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
    
    alias process_citation_cluster process

    def append
      raise NotImplementedByEngine
    end
    
    alias append_citation_cluster append

    def preview
      raise NotImplementedByEngine
    end
    
    alias preview_citation_cluster preview
    
    def bibliography
      raise NotImplementedByEngine
    end
    
    alias make_bibliography bibliography
    
    def update_items
      raise NotImplementedByEngine
    end
    
    def update_uncited_items
      raise NotImplementedByEngine
    end
            
  end

end
