
module CiteProc
  class Processor

    extend Forwardable
    
    @defaults = {
      :locale => 'en-US',
      :style  => 'chicago-author-date',
      :engine => 'citeproc-js',
      :format => 'html'
    }

    class << self
      attr_reader :defaults
    end

    attr_reader :options, :engine, :items
    
    def_delegators :@engine, :process, :append, :preview, :bibliography, :style, :abbreviate, :abbreviations, :abbreviations=
     
    def initialize(options = {})
      @options = Processor.defaults.merge(options)
      @engine = Engine.autodetect(@options).new(:processor => self)
      style = @options[:style]
      locales = @options[:locale]
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
    
		private
		
		def extract_citation_data(items, options = {})
			
		end
		
  end
end
