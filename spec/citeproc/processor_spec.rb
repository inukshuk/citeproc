require 'spec_helper'

module CiteProc
  describe Processor do
    let(:p) { Processor.new }

    let(:palefire) { Item.new(:id => 'palefire', :type => :book, :title => 'Pale Fire') }
    let(:despair) { Item.new(:id => 'despair', :type => :book, :title => 'Despair') }

    it { is_expected.not_to be nil }

    it { expect(p.engine).not_to be nil }
    it { expect(p.engine.name).to eq('citeproc-ruby') }

    describe '#register' do

      it 'adds the passed-in item to the items hash' do
        expect { p.register(palefire) }.to change { p.items.length }.by(1)
      end

      it 'register the item with its id' do
        expect { p.register(palefire) }.to change { p.has_key?('palefire') }
      end

    end

    describe '#<<' do

      it 'registers the passed in item' do
        expect { p << palefire }.to change { p.has_key?('palefire') }
      end

      it 'returns the processor' do
        expect(p << palefire).to be_equal(p)
      end

    end

    describe '#[]' do

      describe 'when there is no item with the passed-in id' do
        it 'returns nil' do
          expect(p[:palefire]).to be nil
        end
      end

      describe 'when there is an item with the passed-in id' do
        before(:each) { p.register(palefire) }

        it 'returns the item' do
          expect(p[:palefire]).to equal(palefire)
        end
      end
    end

    describe '#update' do

      it 'accepts a single item and adds it to the item hash' do
        expect { p.update(palefire) }.to change { p.items.length }.by(1)
      end

      it 'registers the passed-in item with its id' do
        expect { p.update(palefire) }.to change { p[:palefire] }.from(nil).to(palefire)
      end

      describe 'when passed a hash' do
        it 'registers the value with the key as id' do
          expect(p.update(:foo => palefire)[:foo]).to equal(palefire)
        end

        it 'converts the value to an item' do
          expect(p.update(:foo => { :title => 'The Story of Foo' })[:foo]).to be_a(Item)
        end
      end

      it 'adds all items in the array when passed an array' do
        expect { p.update([palefire, despair]) }.to change { p.items.length }.by(2)
      end

      it 'adds all items in when passed multiple items' do
        expect { p.update(palefire, despair) }.to change { p.items.length }.by(2)
      end

    end

    describe '#bibliography (generates the bibliography)' do

      describe 'when no items have been processed' do

        it 'returns an empty bibliography' do
          expect(p.bibliography).to be_empty
        end

        # it 'returns a bibliography of all registered items if invoked with :all'

      end

      describe 'when items have been processed' do

        it 'returns a bibliography containing all cited items'

        # it 'returns a bibliography of all registered items if invoked with :all'

        describe 'when invoked with a block as filter' do

          it 'returns an empty bibliography if the block always returns false'

          it 'returns the full bibliography if the block always returns true'

          it 'returns a bibliography with all items for which the block returns true'

        end

        describe 'when passed a hash as argument' do

          it 'fails if the hash is no valid selector'

          it 'creates a selector from the hash and returns a bibliography containing all matching items'

        end

      end

    end

  end
end
