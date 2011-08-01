
module CiteProc
  class Processor

    attr_reader :options, :engine
    
    class << self
      def defaults
        @defaults ||= {
          :locale => 'en-US',
          :style  => 'chicago-author-date',
          :engine => 'ruby',
          :format => 'html'
        }
      end
    end
    
    def initialize(options = {})
      @options = Processor.defaults.merge(options)
      @engine = Engine.detect(options)
    end
    
  end
end