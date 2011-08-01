require 'spec_helper'

module CiteProc
  describe 'Processor' do
    
    let(:processor) { Processor.new }
    
    describe '#new' do
      it { should_not be nil }
    end
    
  end
end