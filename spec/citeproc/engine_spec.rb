require 'spec_helper'

module CiteProc
  describe 'Engine' do
    let(:engine) { Engine.new }
    
    describe '#abbreviations' do
      it 'returns a hash of abbreviations' do
        engine.abbreviations.should be_an_instance_of(Hash)
      end
      
      it 'should contain the default namespace' do
        engine.abbreviations.should have_key(:default)
      end
    end
    
    describe '#abbreviations=' do
      context 'given a hash' do
        let(:abbrev) { Hash[:foo, :bar] }
        it 'uses the hash as the new set of abbreviations' do
          engine.abbreviations = abbrev
          engine.abbreviations.should == abbrev
          engine.abbreviations.should_not equal(abbrev)
        end
      end
      
      context 'given a string' do
        let(:abbrev) { '{"foo":"bar"}' }
        it 'uses the hash as the new set of abbreviations' do
          engine.abbreviations = abbrev
          engine.abbreviations.should == Hash[:foo,'bar']
        end
      end
    end
    
    describe '#abbreviate' do
    end
    
  end
end