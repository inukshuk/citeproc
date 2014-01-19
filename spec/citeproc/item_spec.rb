require 'spec_helper'

module CiteProc
  describe Item do


    describe '.new' do
      it { should_not be nil }

      it 'creates number variables for number fields' do
        Item.new(:edition => 23).edition.should be_a(Number)
      end

      it 'creates text variable for text fields' do
        Item.new(:ISBN => 23).isbn.should be_a(Text)
      end

      it 'creates date variables for date fields' do
        Item.new(:accessed => Time.now).accessed.should be_a(CiteProc::Date)
      end

      it 'creates names variables for name fields' do
        Item.new(:editor => { :given => 'Jane' }).editor.should be_a(Names)
        Item.new(:editor => 'Plato and Socrates').editor.should have(2).names
      end

      it 'creates text variables for unknown fields' do
        v = Item.new(:unknown => 42)[:unknown]
        v.should be_a(Variable)
        v.should == '42'
      end
    end

    describe '#empty' do
      it { should be_empty }

      it 'returns false when there is at least one variable in the item' do
        Item.new(:title => 'foo').should_not be_empty
      end
    end

    describe '#each' do
      it 'yields each variable to the given block' do
        Item.new(:title => 'foo', :edition => 2).each.map {|kv| kv.join('-') }.sort.should == %w{edition-2 title-foo}
      end
    end

    describe '#each_value' do
      it "yields each variable's value to the given block" do
        Item.new(:title => 'foo', :edition => 2).each_value.map(&:to_s).sort.should == %w{2 foo}
      end
    end

    describe '#to_citeproc' do
      it 'returns an empty hash by default' do
        Item.new.to_citeproc.should == {}
      end

      it 'returns a hash with stringified keys' do
        Item.new(:issue => 42).to_citeproc.should have_key('issue')
      end

      it 'returns a hash with stringified values' do
        Item.new(:issue => 42).to_citeproc.values[0].should == '42'
      end
    end

    describe '#dup' do
      it 'returns a copy' do
        item = Item.new
        item.dup.should_not equal(item)
      end

      it 'copies all variables' do
        Item.new(:issued => 1976).dup[:issued].year.should == 1976
      end
    end
  end
end
