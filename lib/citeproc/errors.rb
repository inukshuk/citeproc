module CiteProc

  class Error < StandardError
    attr_reader :original

    def initialize(message, original = $!)
      @original = original
			super(message)
    end
  end

	ParseError = Class.new(Error)

  EngineError = Class.new(Error)

  NotImplementedByEngine = Class.new(Error)

  RenderingError = Class.new(Error)
end
