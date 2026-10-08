require 'spec_helper'

module CiteProc
  describe Item do


    describe '.new' do
      it { is_expected.not_to be nil }

      it 'creates number variables for number fields' do
        expect(Item.new(:edition => 23).edition).to be_a(Number)
      end

      it 'maps legacy CSL-JSON names of short forms' do
        item = Item.new('journalAbbreviation' => 'Anon J', 'shortTitle' => 'Short')
        expect(item[:'container-title-short'].to_s).to eq('Anon J')
        expect(item[:'title-short'].to_s).to eq('Short')
        expect(item[:journalAbbreviation]).to be_nil
      end

      it 'does not override short forms with legacy names' do
        item = Item.new('container-title-short' => 'J-1', 'journalAbbreviation' => 'Anon J')
        expect(item[:'container-title-short'].to_s).to eq('J-1')
      end

      it 'creates text variable for text fields' do
        expect(Item.new(:ISBN => 23).isbn).to be_a(Text)
      end

      it 'creates date variables for date fields' do
        expect(Item.new(:accessed => Time.now).accessed).to be_a(CiteProc::Date)
      end

      it 'creates names variables for name fields' do
        expect(Item.new(:editor => { :given => 'Jane' }).editor).to be_a(Names)
        expect(Item.new(:editor => 'Plato and Socrates').editor.names.size).to eq(2)
      end

      it 'creates text variables for unknown fields' do
        v = Item.new(:unknown => 42)[:unknown]
        expect(v).to be_a(Variable)
        expect(v).to eq('42')
      end
    end

    describe '#empty' do
      it { is_expected.to be_empty }

      it 'returns false when there is at least one variable in the item' do
        expect(Item.new(:title => 'foo')).not_to be_empty
      end
    end

    describe '#each' do
      it 'yields each variable to the given block' do
        expect(Item.new(:title => 'foo', :edition => 2).each.map {|kv| kv.join('-') }.sort).to eq(%w{edition-2 title-foo})
      end
    end

    describe '#each_value' do
      it "yields each variable's value to the given block" do
        expect(Item.new(:title => 'foo', :edition => 2).each_value.map(&:to_s).sort).to eq(%w{2 foo})
      end
    end

    describe '#to_citeproc' do
      it 'returns an empty hash by default' do
        expect(Item.new.to_citeproc).to eq({})
      end

      it 'returns a hash with stringified keys' do
        expect(Item.new(:issue => 42).to_citeproc).to have_key('issue')
      end

      it 'returns a hash with stringified values' do
        expect(Item.new(:issue => 42).to_citeproc.values[0]).to eq('42')
      end
    end

    describe '#dup' do
      it 'returns a copy' do
        item = Item.new
        expect(item.dup).not_to equal(item)
      end

      it 'copies all variables' do
        expect(Item.new(:issued => 1976).dup[:issued].year).to eq(1976)
      end
    end

    describe '#attribute?' do
      it 'should not trigger an observable read' do
        obs = Object.new
        def obs.update
        end
        expect(obs).not_to receive(:update)
        item = Item.new(:issued => 1976)
        item.add_observer(obs)
        item.attribute?(:issued)
      end
    end

    describe '#read_attribute' do
      it 'reports suppressed variables as empty to observers' do
        obs = Object.new
        def obs.update(*arguments)
        end
        expect(obs).to receive(:update).with(:read, :title, nil)
        item = Item.new(:title => 'T').suppress!('title')
        item.add_observer(obs)
        expect(item[:title]).to be_nil
      end
    end

    describe '#eql?' do
      it 'is true for items with the same data' do
        a = Item.new(:id => 'x', :title => 'T', :issued => [[2003]])
        b = Item.new(:id => 'x', :title => 'T', :issued => [[2003]])

        expect(a).to eql(b)
        expect([a, b].uniq.length).to eq(1)
      end

      it 'is false for items with different data' do
        expect(Item.new(:id => 'x', :title => 'T')).not_to eql(Item.new(:id => 'x', :title => 'U'))
      end
    end
  end
end
