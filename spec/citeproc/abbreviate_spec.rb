require 'spec_helper'

module CiteProc
  describe Abbreviate do
    before { Object.class_eval { include Abbreviate } }

    let(:subject) { Object.new }
        
    describe '#abbreviations=' do
      context 'given a hash' do
        let(:abbrev) { Hash[:foo, :bar] }
        it 'uses the hash as the new set of abbreviations' do
          subject.abbreviations = abbrev
          expect(subject.abbreviations).to eq(abbrev)
          expect(subject.abbreviations).not_to equal(abbrev)
        end
      end
      
      context 'given a string' do
        let(:abbrev) { '{"foo":"bar"}' }
        it 'uses the hash as the new set of abbreviations' do
          subject.abbreviations = abbrev
          expect(subject.abbreviations).to eq(Hash[:foo,'bar'])
        end
      end
    end
    
    describe '#abbreviate' do
      it 'looks up abbreviations in the default namespace by default' do
        expect(subject.abbreviate(:title, 'foo')).to eq(nil)
        subject.abbreviations[:default][:title] = { 'foo' => 'bar' }
        expect(subject.abbreviate(:title, 'foo')).to eq('bar')
      end
    end
    
  end
end
