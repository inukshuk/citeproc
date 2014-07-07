module CiteProc

	describe 'Assets' do

		before(:all) do
		  @file = Tempfile.new('asset')
			@file.write("asset content\n")
			@file.close
			
			@root = File.dirname(@file.path)
			@name = File.basename(@file.path)
			
			@extension = File.extname(@name)
		end

		after(:all) { @file.unlink }

		describe 'Style' do

			before(:all) do
				@default_root = Style.root
				@default_extension = Style.extension
				Style.root = @root
				Style.extension = @extension
			end

			after(:all) do
				Style.root = @default_root
				Style.extension = @default_extension
			end

			it 'should not be open by default' do
				expect(Style.new).not_to be_open
			end
			
			describe '.open' do  

				it 'accepts an absolute file name' do
					expect(Style.open(@file.path).to_s).to eq("asset content\n")
				end

				it 'accepts a file name' do
					expect(Style.open(@name).to_s).to eq("asset content\n")
				end

				it 'accepts a file name without extension' do
					expect(Style.open(@name.sub(/#{@extension}$/,'')).to_s).to eq("asset content\n")
				end


				it 'accepts an io object' do
					expect(Style.open(@file.open).to_s).to eq("asset content\n")
				end

				it 'returns the given string if it looks like XML' do
					expect(Style.open('<b>foo bar!</b>').to_s).to eq('<b>foo bar!</b>')
				end
			end

      describe '.extend_name' do
        it 'adds the default extension if the file does not already end with it' do
          expect(Style.extend_name(@name.sub(/#{@extension}$/,''))).to eq(@name)
        end
        
        it 'does not add the default extension if the file already ends with it' do
          expect(Style.extend_name(@name)).to eq(@name)
        end
      end
      
		end
	end
end
