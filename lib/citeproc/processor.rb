
module CiteProc
  class Processor

    extend Forwardable
    
    @defaults ||= {
      :locale => 'en-US',
      :style  => 'chicago-author-date',
      :engine => 'citeproc-js',
      :format => 'html'
    }

    class << self
      attr_reader :defaults
    end

    attr_reader :options, :engine, :items
    
    def_delegators :@engine, :process, :append, :preview, :bibliography, :style, :style=, :abbreviate, :abbreviations, :abbreviations=
     
    def initialize(options = {})
      @options = Processor.defaults.merge(options)
      @engine = Engine.autodetect(@options).new(:processor => self)
      @items = {}
    end
    
  end
end
