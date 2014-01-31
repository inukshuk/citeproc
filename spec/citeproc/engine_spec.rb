require 'spec_helper'

module CiteProc
  describe Engine do

    it 'cannot be instantiated' do
      lambda { Engine.new }.should raise_error(NoMethodError)
    end

    describe 'subclasses' do
      let(:subject) { Class.new(Engine).new }

      it 'can be instantiated' do
        subject.should_not be nil
      end
    end

  end
end
