require 'spec_helper'

module CiteProc
  
  describe Bibliography do
    
    it { should be_empty }
    it { should_not have_errors }
    
    describe '#to_citeproc conversion' do
      
      it 'returns an array' do
        subject.to_citeproc.should be_a(Array)
      end
      
      it 'returns exactly two elements' do
        subject.to_citeproc.should have(2).elements
      end
      
      it 'returns formatting options as the first element' do
        subject.to_citeproc.first.should be_a(Hash)
      end

      describe 'the formatting options' do
        let(:options) { subject.to_citeproc[0] }
        
        it 'contains a the error list' do
          options.should have_key('bibliography_errors')
          options['bibliography_errors'].should be_empty
        end
        
      end
      
      it 'returns the list of references as the second element' do
        subject.to_citeproc.last.should be_a(Array)
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
        b = Bibliography.create(js)
        b.should be_a(Bibliography)
        b.should have(2).references
        b.should_not have_errors
        b.options[:align].should be true
      end
      
    end
    
  end
  
end
