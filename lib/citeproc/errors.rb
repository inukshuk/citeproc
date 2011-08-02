module CiteProc

  class Error < StandardError
    attr_reader :original

    def initialize(message, original = nil)
      @original = original ? super([message, original.message].join(': ')) : super(message)
    end    
  end
  
  class EngineError < Error
  end
  
  class NotImplementedByEngine < EngineError
  end
  
end