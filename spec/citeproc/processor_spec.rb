require 'spec_helper'

module CiteProc
  describe Processor do
    before { Class.new(Engine) }
    
    let(:subject) { Processor.new }
    
    it { should_not be nil }
    

		describe '#bibliography (generates the bibliography)' do
			
			describe 'when no items have been processed' do
				
				it 'returns an empty bibliography'
				
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