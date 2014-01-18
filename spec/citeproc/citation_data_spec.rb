require 'spec_helper'

module CiteProc

  describe 'citation input' do

    let(:hash) {{
      "citationItems" => [
        {
          "id" => "ITEM-1"
        }
      ],
      "properties" => {
        "noteIndex" => 1
      }
    }}

    let(:json) { ::JSON.dump(hash) }



    describe CitationData do

      it { should_not be nil }
      it { should be_empty }

      it 'has not been processed by default' do
        CitationData.new.should_not be_processed
      end

      describe '.new' do

        it 'accepts a citeproc hash' do
          d = CitationData.new(hash)
          d.should be_footnote
          d.should_not be_empty
          d[0].should be_a(CitationItem)
          d.index.should == 1
        end

        it 'accepts an array of items' do
          CitationData.new([CitationItem.new(:id => 'id')]).should have(1).items
        end

        it 'accepts an array of hashes' do
          CitationData.new([{:id => 'id'}])[0].should be_a(CitationItem)
        end

      end

      describe '#to_citeproc' do

        it 'returns empty an empty/default citation data element by default' do
          CitationData.new.to_citeproc.should == { 'citationItems' => [], 'properties' => { 'noteIndex' => 0}}
        end


      end

    end

    describe CitationItem do

      it { should_not be nil }
      it { should be_empty }

      describe '.new' do

        it 'accepts a hash as input' do
          CitationItem.new(:label => 'chapter').should have_label
        end

      end

      describe '#to_citeproc' do

        it 'returns empty citation data by default' do
          CitationItem.new.to_citeproc.should == {}
        end

        it 'returns a hash with stringified keys' do
          CitationItem.new(:type => :article).to_citeproc.should have_key('type')
        end

        it 'returns a hash with stringified values' do
          CitationItem.new(:type => :article).to_citeproc.should have_value('article')
        end

      end

    end

  end
end
