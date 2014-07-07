require 'spec_helper'

describe Hash do
  let(:hash) { { :a => { :b => { :c => :d } } } }
  

  describe '#deep_copy' do
    it { expect(hash).to respond_to(:deep_copy) }

    it 'returns a copy equal to the hash' do
      expect(hash.deep_copy).to eq(hash)
    end
    
    it 'returns a copy that is not identical to the hash' do
      expect(hash.deep_copy).not_to equal(hash)
    end
    
    it 'returns a deep copy' do
      expect(hash.deep_copy[:a]).to eq(hash[:a])
      expect(hash.deep_copy[:a]).not_to equal(hash[:a])
      expect(hash.deep_copy[:a][:b]).to eq(hash[:a][:b])
      expect(hash.deep_copy[:a][:b]).not_to equal(hash[:a][:b])
      expect(hash.deep_copy[:a][:b][:c]).to eq(hash[:a][:b][:c])
    end

    context 'when given nested arrays' do
      let(:hash) {{:a => [[1,2]]}}
      it 'it returns a deep copy' do
        expect(hash.deep_copy[:a]).to eq(hash[:a])
        expect(hash.deep_copy[:a]).not_to equal(hash[:a])
      end
      
    end
  end
  
  describe '#deep_fetch' do
    # it 'behaves like normal for two arguments' do
    #   hash.fetch(:b, 42).should == 42
    # end
    # 
    # it 'behaves like normal for one argument and a block' do
    #   hash.fetch(:b) {42}.should == 42
    # end
    
    it 'returns the value of all the arguments applied as keys' do
      expect(hash.deep_fetch(:a, :b, :c)).to eq(:d)
    end
    
    it 'returns nil if any of the values did not exist' do
      expect(hash.deep_fetch(:x, :b, :c)).to be nil
      expect(hash.deep_fetch(:a, :x, :c)).to be nil
      expect(hash.deep_fetch(:a, :b, :x)).to be nil
    end

  end

end

describe Array do
	
	describe '#compact_join' do
		
		it 'is equivalent to #join when there are no blank elements' do
			expect([1,2,3].compact_join(' ')).to eq([1,2,3].join(' '))
		end

		it 'is equivalent to #compact and #join when there are no empty elements' do
			expect([1,2,3,nil,nil,4].compact_join(' ')).to eq([1,2,3,nil,nil,4].compact.join(' '))
		end
	
		it 'returns an empty string if the array is empty' do
			expect([].compact_join(' ')).to eq('')
		end
	
		it 'returns an empty string if there are only nil elements' do
			expect([nil,nil,nil].compact_join(' ')).to eq('')
		end
		
		it 'returns an empty string if there are only empty elements' do
			expect(['','',''].compact_join(' ')).to eq('')
		end

		it 'returns an empty string if there are only blank elements' do
			expect(['','',nil,'',nil].compact_join(' ')).to eq('')
		end
		
	end
	
end