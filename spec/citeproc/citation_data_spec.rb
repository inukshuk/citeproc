require 'spec_helper'

module CiteProc
	
	describe CitationData do

		it { should_not be nil }
#		it { should be_empty }

		it 'has not been processed by default' # do
		# 	CitationData.new.should_not be_processed
		# end
		
		describe '#to_citeproc' do
			
			it 'returns empty hash by default' do
				CitationData.new.to_citeproc.should == {}
			end
			
			
		end
		
	end
	
	describe CitationItem do
		
		it { should_not be nil }
		it { should be_empty }
	
		describe '#to_citeproc' do
			
			it 'returns empty hash by default' do
				CitationItem.new.to_citeproc.should == {}
			end
			
			it 'returns a hash with stringified keys'

			it 'returns a hash with stringified values'
			
		end
		
	end
	
end