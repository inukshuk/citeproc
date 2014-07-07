require 'spec_helper'

module CiteProc
  describe Attributes do
  
    before(:all) do
			A = Class.new { include Attributes }
		end
  
    let(:instance) do
			o = A.new
			o[:bar] = 'foo'
			o
		end

    let(:other) do
	 		o = A.new
			o[:foo] = 'bar'
			o
		end
  
    it { should_not be_nil }
  
    describe '.attr_fields' do
    
			#       before(:all) do
			# 	A.instance_eval { attr_fields :value, %w[ is-numeric punctuation-mode ] }
			# end

      it 'generates setters for attr_field values' do
        # pending
        # lambda { A.new.is_numeric }.should_not raise_error
      end
    
      it 'generates no other setters' do
        expect { A.new.some_other_value }.to raise_error
      end
    end
  
    describe '#merge' do    
    
      it 'merges non-existent values from other object' do
        expect(A.new.merge(other)[:foo]).to eq('bar')
      end
    
      it 'does not overwrite existing values when merging other object' do
        expect(instance.merge(other)[:bar]).to eq('foo')
      end
    
    end
  
  end
end