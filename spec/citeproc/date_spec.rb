require 'spec_helper'

module CiteProc
  describe Date do
    
    it { should_not be nil }
    
    it { should_not be_numeric }
    
    describe '.new' do
      
    end
    
    describe '.create' do
      it 'should accept parameters and return a new instance' do
        Date.create('date-parts' => [[2001, 1]]).year.should == 2001
      end
    end
    
    describe 'literal dates' do      
      it 'is not literal by default' do
        Date.new.should_not be_literal
      end
      
      it 'is literal if it contains only a literal field' do
        Date.create(:literal => 'foo').should be_literal
      end
      
      it 'is literal if it contains a literal field' do
        Date.create('date-parts' => [[2000]], :literal => 'foo').should be_literal
      end
    end
    
    describe 'uncertain dates' do
      it 'are uncertain' do
        Date.new({ 'date-parts' => [[-225]], 'circa' => '1' }).should be_uncertain
        Date.new { |d| d.parts = [[-225]]; d.uncertain! }.should be_uncertain
      end
    end
    
    describe 'sorting' do
      
      let(:ad2k) { Date.create('date-parts' => [[2000]])}
      let(:may) { Date.create('date-parts' => [[2000, 5]])}
      let(:first_of_may) { Date.create('date-parts' => [[2000, 5, 1]])}
      
      let(:bc100) { Date.create('date-parts' => [[-100]]) }
      let(:bc50) { Date.create('date-parts' => [[-50]]) }
      let(:ad50) { Date.create('date-parts' => [[50]]) }
      let(:ad100) { Date.create('date-parts' => [[100]]) }

      it 'dates with more date-parts will come after those with fewer parts' do
        (ad2k < may  && may < first_of_may).should be true
      end
      
      it 'negative years are sorted inversely' do
        [ad50, bc100, bc50, ad100].sort.map(&:year).should == [-100, -50, 50, 100]
      end
    end


    describe '#display' do
      it 'returns an empty string by default' do
        Date.new({}).to_s == ''
      end
    end

    describe '#to_json' do    
      it 'supports simple parts' do
        Date.new(%w{2000 1 15}).to_json.should == '{"date-parts":[[2000,1,15]]}'
      end

      it 'supports integers and strings parts' do
        Date.new(['2000', '1', '15']).to_json.should == '{"date-parts":[[2000,1,15]]}'
        Date.new([2000, 1, 15]).to_json.should == '{"date-parts":[[2000,1,15]]}'
        Date.new(['2000', 1, '15']).to_json.should == '{"date-parts":[[2000,1,15]]}'
      end

      it 'supports negative years' do
        Date.new(-200).to_json.should == '{"date-parts":[[-200]]}'
      end

      it 'supports seasons' do
        Date.create({:season => '1', 'date-parts' => [[1950]]}).to_json.should == '{"date-parts":[[1950]],"season":"1"}'
        Date.create({:season => 'Trinity', 'date-parts' => [[1975]]}).to_json.should == '{"date-parts":[[1975]],"season":"Trinity"}'
      end

      it 'supports string literals' do
        Date.new(:literal => '13th century').to_json.should == '{"literal":"13th century"}'
      end

      it 'supports raw strings' do
        Date.new(:raw => '23 May 1955').to_json.should == '{"date-parts":[[1955,5,23]]}'
      end

      it 'supports open and closed ranges' do
        Date.new([[2000,11],[2000,12]]).to_json.should == '{"date-parts":[[2000,11],[2000,12]]}'
        Date.new([[2000,11],[0,0]]).to_json.should == '{"date-parts":[[2000,11],[0,0]]}'
      end
    end

  end
end
