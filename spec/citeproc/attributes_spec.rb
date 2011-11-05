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
        lambda { A.new.some_other_value }.should raise_error
      end
    end
  
    describe '#merge' do    
    
      it 'merges non-existent values from other object' do
        A.new.merge(other)[:foo].should == 'bar'
      end
    
      it 'does not overwrite existing values when merging other object' do
        instance.merge(other)[:bar].should == 'foo'
      end
    
    end
  
  end
end