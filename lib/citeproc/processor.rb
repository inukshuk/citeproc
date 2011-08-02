
module CiteProc
  class Processor

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
     
    def initialize(options = {})
      @options = Processor.defaults.merge(options)
      @engine = Engine.autodetect(@options).new :processor => self
    end
    
  end
end