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
    
      describe '.load' do  
      
        it 'accepts an absolute file name' do
          Style.load(file.path).to_s.should == "asset content\n"
        end

        it 'accepts a file name' do
          Style.load(name).to_s.should == "asset content\n"
        end

        it 'accepts a file name without extension' do
          Style.load(name.sub(/#{extension}$/,'')).to_s.should == "asset content\n"
        end
                
                
        it 'accepts a uri' do
          pending
        end
      
        it 'returns the given string if it is neither file nor uri' do
          Style.load('foo bar!').to_s.should == 'foo bar!'
        end
      
      end
    
    end
  end
end
