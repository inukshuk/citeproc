require 'spec_helper'

module CiteProc
	describe Item do
		
		it { should_not be nil }
		it { should be_empty }
		
		describe '.new' do
			
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
			end
			
			it 'creates text variables for unknown fields' do
				v = Item.new(:unknown => 42)[:unknown]
				v.should be_a(Variable)
				v.should == '42'
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
	end
end