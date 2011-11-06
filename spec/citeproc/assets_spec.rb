require 'spec_helper'
require 'tempfile'

module CiteProc

	describe 'Assets' do
		let(:file) { Tempfile.new('asset') }
		let(:root) { File.dirname(file.path) }
		let(:name) { File.basename(file.path) }
		let(:extension) { File.extname(name) }

		before(:all) do
			file.write("asset content\n")
			file.close
		end

		after(:all) { file.unlink }

		describe 'Style' do

			before(:all) do
				@default_root = Style.root
				@default_extension = Style.extension
				Style.root = root
				Style.extension = extension
			end

			after(:all) do
				Style.root = @default_root
				Style.extension = @default_extension
			end

			it 'should not be open by default' do
				Style.new.should_not be_open
			end
			
			describe '.open' do  

				it 'accepts an absolute file name' do
					Style.open(file.path).to_s.should == "asset content\n"
				end

				it 'accepts a file name' do
					Style.open(name).to_s.should == "asset content\n"
				end

				it 'accepts a file name without extension' do
					Style.open(name.sub(/#{extension}$/,'')).to_s.should == "asset content\n"
				end


				it 'accepts an io object' do
					Style.open(file.open).to_s.should == "asset content\n"
				end

				it 'returns the given string if it looks like XML' do
					Style.open('<b>foo bar!</b>').to_s.should == '<b>foo bar!</b>'
				end

			end

		end
	end
end
