require 'spec_helper'

module CiteProc
  describe Engine do

    it 'cannot be instantiated' do
      expect { Engine.new }.to raise_error(NoMethodError)
    end

    describe 'subclasses' do
      let(:subject) { Class.new(Engine).new }

      it 'can be instantiated' do
        expect(subject).not_to be nil
      end
    end

  end
end
