require 'spec_helper'

module CiteProc
  describe Engine do

    it 'cannot be instantiated' do
      lambda { Engine.new }.should raise_error(NoMethodError)
    end
    
    describe 'subclasses' do
      let(:subject) { Class.new(Engine).new { |e| e.processor = double(:processor) } }

      it 'can be instantiated' do
        subject.should_not be nil
      end
      
      it 'can be started' do
        expect { subject.start }.to change { subject.running? }.from(false).to(true)
      end
      
    end
    
  end
end