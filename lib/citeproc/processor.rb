
module CiteProc
	class Processor

		extend Forwardable
    include Abbreviate

		@defaults = {
			:locale => 'en-US',
			:style  => 'chicago-author-date',
			:engine => 'citeproc-js',
			:format => 'html'
		}.freeze

		class << self
			attr_reader :defaults
		end

		attr_reader :options, :items
		attr_writer :engine

		def_delegators :@locale, :language, :region
		
		def initialize(options = {})
			@options, @items = Processor.defaults.merge(options), {}
		end

		def engine
			@engine ||= Engine.autodetect(options).new(self)
		end

		def style
			@style || load_style
		end
		
		def locale
			@locale || load_locale
		end
		
		def load_style
			@style = Style.open(options[:style])
		end

		def load_locale
			@locale = Locale.open(options[:locale])
		end


		def process(*arguments)
			engine.process(CitationData(arguments.flatten(1)))
		end

		def append(*arguments)
			engine.append(CitationData(arguments.flatten(1)))
		end

		def bibliography(*arguments, &block)
			engine.bibliography(Selector.new(*arguments, &block))
		end

		def inspect
			"#<CiteProc::Processor style=#{style.name.inspect} locale=#{locale.name.inspect} items=[#{items.length}]>"
		end
		
	end
end
