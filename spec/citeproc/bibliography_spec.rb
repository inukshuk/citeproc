require 'spec_helper'

module CiteProc

  describe Bibliography do

    it { is_expected.to be_empty }
    it { is_expected.not_to have_errors }

    describe '#hanging_indent?' do
      it 'returns false by default' do
        expect(Bibliography.new).not_to be_hanging_indent
      end

      it 'returns the value of the hanging-indent option' do
        expect(Bibliography.new(:'hanging-indent' => 'true')).to be_hanging_indent
        expect(Bibliography.new(:'hanging-indent' => 'false')).not_to be_hanging_indent
      end
    end

    describe '#to_citeproc conversion' do

      it 'returns an array' do
        expect(subject.to_citeproc).to be_a(Array)
      end

      it 'returns exactly two elements' do
        expect(subject.to_citeproc.size).to eq(2)
      end

      it 'returns formatting options as the first element' do
        expect(subject.to_citeproc.first).to be_a(Hash)
      end

      describe 'the formatting options' do
        let(:options) { subject.to_citeproc[0] }

        it 'contains a the error list' do
          expect(options).to have_key('bibliography_errors')
          expect(options['bibliography_errors']).to be_empty
        end

      end

      it 'returns the list of references as the second element' do
        expect(subject.to_citeproc.last).to be_a(Array)
      end

    end

    describe '.create (citeproc parser)' do
      let(:js) { <<-JS_END }
      [
        {
          "maxoffset": 0,
          "entryspacing": 0,
          "linespacing": 0,
          "hangingindent": 0,
          "second-field-align": true,
          "bibstart": "<div class=\\"csl-bib-body\\">\\n",
          "bibend": "</div>",
          "bibliography_errors": []
        },
        [
          "<div class=\\"csl-entry\\">Book A</div>",
          "<div class=\\"csl-entry\\">Book C</div>"
        ]
      ]
      JS_END

      it 'parses citeproc/json strings' do
        b = Bibliography.create!(js)
        expect(b).to be_a(Bibliography)
        expect(b.references.size).to eq(2)
        expect(b).not_to have_errors
        expect(b.options[:'second-field-align']).to be true
      end

    end

  end

end
