module CiteProc

  class Error < StandardError
    attr_reader :original

    def initialize(message, original = $!)
      @original = original
			super(message)
    end    
  end
  
	class ParseError < Error; end
	
  class EngineError < Error; end
  
  class NotImplementedByEngine < EngineError; end
  
end