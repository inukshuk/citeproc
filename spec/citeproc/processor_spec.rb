require 'spec_helper'

module CiteProc
  describe Processor do
    before { Class.new(Engine) }
    
    let(:subject) { Processor.new }
    
    it { should_not be nil }
    
  end
end