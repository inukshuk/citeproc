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

      it { is_expected.not_to be nil }
      it { is_expected.to be_empty }

      it 'has not been processed by default' do
        expect(CitationData.new).not_to be_processed
      end

      describe '.new' do

        it 'accepts a citeproc hash' do
          d = CitationData.new(hash)
          expect(d).to be_footnote
          expect(d).not_to be_empty
          expect(d[0]).to be_a(CitationItem)
          expect(d.index).to eq(1)
        end

        it 'accepts an array of items' do
          expect(CitationData.new([CitationItem.new(:id => 'id')]).items.size).to eq(1)
        end

        it 'accepts an array of hashes' do
          expect(CitationData.new([{:id => 'id'}])[0]).to be_a(CitationItem)
        end

      end

      describe '#to_citeproc' do

        it 'returns empty an empty/default citation data element by default' do
          expect(CitationData.new.to_citeproc).to eq({ 'citationItems' => [], 'properties' => { 'noteIndex' => 0}})
        end


      end

    end

    describe CitationItem do

      it { is_expected.not_to be nil }
      it { is_expected.to be_empty }

      describe '.new' do

        it 'accepts a hash as input' do
          expect(CitationItem.new(:label => 'chapter')).to have_label
        end

      end

      describe '#to_citeproc' do

        it 'returns empty citation data by default' do
          expect(CitationItem.new.to_citeproc).to eq({})
        end

        it 'returns a hash with stringified keys' do
          expect(CitationItem.new(:type => :article).to_citeproc).to have_key('type')
        end

        it 'returns a hash with stringified values' do
          expect(CitationItem.new(:type => :article).to_citeproc).to have_value('article')
        end

      end

    end

  end
end
