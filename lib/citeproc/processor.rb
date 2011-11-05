
module CiteProc
  class Processor

    extend Forwardable
    
    @defaults = {
      :locale => 'en-US',
      :style  => 'chicago-author-date',
      :engine => 'citeproc-js',
      :format => 'html'
    }.freeze

    class << self
      attr_reader :defaults
    end

    attr_reader :options, :engine, :items, :style
    
    def_delegators :@engine, :abbreviate, :abbreviations, :abbreviations=
     
    def initialize(options = {})
      @options = Processor.defaults.merge(options)
      @engine = Engine.autodetect(@options).new(:processor => self)
      @style = Style.load(@options[:style])
      @locales = @options[:locale]
      @items = {}
    end
    
		def style=(style)
		  @style = Style.load(style.to_s)
		  @engine.style = @style
		  @style
	  end
	  
	  def locales=(locale)
      @locales = { locale.to_sym => Locale.load(locale.to_s) }
      @engine.locales = @locales
      @locales
    end

		def process(*arguments)
			@engine.process(CitationData(arguments.flatten(1)))
		end
		
		def append(*arguments)
			@engine.append(CitationData(arguments.flatten(1)))
		end
		
		def bibliography(*arguments, &block)
			@engine.bibliography(Selector.new(*arguments, &block))
		end
    		
  end
end
