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

    it { is_expected.not_to be_nil }

    describe '.attr_fields' do

      # before(:all) do
      #   A.instance_eval { attr_fields :value, %w[ is-numeric punctuation-mode ] }
      # end

      it 'generates setters for attr_field values' do
        # pending
        # lambda { A.new.is_numeric }.should_not raise_error
      end

      it 'generates no other setters' do
        expect { A.new.some_other_value }.to raise_error(NoMethodError)
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

    describe '#attribute?' do
      it 'return false for unset attribute' do
        expect(A.new.attribute?(:foo)).to eq(false)
      end

      it 'return false for empty attribute value' do
        a = A.new
        a[:foo]=''
        expect(a.attribute?(:foo)).to eq(false)
      end

      it 'return false for attribute value set to string "false"' do
        a = A.new
        a[:foo]='false'
        expect(a.attribute?(:foo)).to eq(false)
      end
      it 'return false for attribute value set to string "no"' do
        a = A.new
        a[:foo]='no'
        expect(a.attribute?(:foo)).to eq(false)
      end
      it 'return false for attribute value set to string "never"' do
        a = A.new
        a[:foo]='never'
        expect(a.attribute?(:foo)).to eq(false)
      end
      it 'return true for attribute with value' do
        a = A.new
        a[:foo]='bar'
        expect(a.attribute?(:foo)).to eq(true)
      end

      describe 'properly handle usage on Observable objects' do
        it 'should use unobservable_read_attribute method when available' do
          a = A.new
          def a.unobservable_read_attribute(attr)
            return 'tuna'
          end
          expect(a).to receive(:unobservable_read_attribute)
          a.attribute?(:foo)
        end
      end
    end

  end
end
