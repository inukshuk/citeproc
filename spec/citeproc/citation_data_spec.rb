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

      describe '#label' do
        it 'returns nil by default' do
          expect(CitationItem.new.label).to be_nil
        end

        it 'defaults to page if there is a locator' do
          expect(CitationItem.new(:locator => '23').label).to eq('page')
          expect(CitationItem.new(:locator => '23', :label => 'chapter').label).to eq('chapter')
        end
      end

      describe '#plural_locator?' do
        it 'returns whether or not the locator is plural' do
          expect(CitationItem.new(:locator => '23')).not_to be_plural_locator
          expect(CitationItem.new(:locator => '23-25')).to be_plural_locator
          expect(CitationItem.new).not_to be_plural_locator
        end

        it 'uses only the locator up to the first embedded label' do
          expect(CitationItem.new(:locator => '1, fol. 186')).not_to be_plural_locator
          expect(CitationItem.new(:locator => '367-368, fig. 333')).to be_plural_locator
          expect(CitationItem.new(:locator => '1, Abb. 2').plural_locator?('Abb.' => 'figure')).to be false
        end
      end

      describe '#parse_locator!' do
        it 'moves labels at the start of the locator into the label' do
          item = CitationItem.new(:locator => 'vol. 1, fol. 186')
          item.parse_locator!
          expect(item.label).to eq('volume')
          expect(item.locator).to eq('1, fol. 186')
        end

        it 'replaces the page label' do
          item = CitationItem.new(:locator => 'ch. 3', :label => 'page')
          item.parse_locator!
          expect(item.label).to eq('chapter')
          expect(item.locator).to eq('3')
        end

        it 'keeps other labels' do
          item = CitationItem.new(:locator => 'vol. 1', :label => 'folio')
          item.parse_locator!
          expect(item.label).to eq('folio')
          expect(item.locator).to eq('vol. 1')
        end

        it 'keeps locators without labels' do
          item = CitationItem.new(:locator => '23-25, fig. 3')
          item.parse_locator!
          expect(item.label).to eq('page')
          expect(item.locator).to eq('23-25, fig. 3')
        end

        it 'accepts additional abbreviations' do
          item = CitationItem.new(:locator => 'S. 23')
          item.parse_locator!('S.' => 'page', 'Bd.' => 'volume')
          expect(item.label).to eq('page')
          expect(item.locator).to eq('23')

          item = CitationItem.new(:locator => 'Bd. 2')
          item.parse_locator!('S.' => 'page', 'Bd.' => 'volume')
          expect(item.label).to eq('volume')
          expect(item.locator).to eq('2')
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
