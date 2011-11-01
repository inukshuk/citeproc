require 'spec_helper'

module CiteProc
  describe Variable do
    
    describe '.new' do
      it { should be_an_instance_of(Variable) }
      
      it 'is empty by default' do
        Variable.new.should be_empty
      end
      
      it 'equals an empty string (==) by default' do
        Variable.new.should == ''
      end
      
      it 'matches an empty pattern by default' do
        Variable.new.should =~ /^$/
      end
      
      it 'accepts a string value' do
        Variable.new('test').should == 'test'
      end

      it 'accepts a numeric value' do
        Variable.new(23).should == '23'
        Variable.new(23.1).should == '23.1'
      end
      
      it 'accepts an attributes hash' do
        Variable.new(:value => 'test').should == 'test'
      end
      
      it 'supports self yielding block' do
        Variable.new { |v| v.value = 'test' }.should == 'test'
      end
    end

    describe '.fields' do
      it 'contains :names fields' do
        Variable.fields[:names].should_not be_empty
        Variable.fields[:name].should equal Variable.fields[:names]
      end

      it 'contains :date fields' do
        Variable.fields[:date].should_not be_empty
        Variable.fields[:dates].should equal Variable.fields[:date]
      end

      it 'contains :text fields' do
        Variable.fields[:text].should_not be_empty
      end

      it 'contains :number fields' do
        Variable.fields[:numbers].should_not be_empty
        Variable.fields[:number].should_not be_empty
      end
      
      it 'accepts either string or symbol input' do
        Variable.fields[:names].should equal Variable.fields['names']
      end  
    end
    
    describe '.types' do
      it 'given a field name returns the corresponding type' do
        Variable.types[:author].should == :names
        Variable.types[:issued].should == :date
        Variable.types[:abstract].should == :text
        Variable.types[:issue].should == :number
      end
      
      it 'accepts either string or symbol input' do
        Variable.types.should have_key(:author)
        Variable.types['author'].should equal Variable.types[:author]
      end
    end
    
    describe '#to_s' do
      it 'displays the value' do
        Variable.new('test').to_s.should == 'test'
      end
    end
    
    describe '#to_i' do
      it 'returns zero by default' do
        Variable.new.to_i.should == 0
      end
      
      context 'when the value is numeric' do
        %w{ -23 -1 0 1 23 }.each do |value|
          it "returns the integer value (#{value})" do
            Variable.new(value).to_i.should equal(value.to_i)
          end
        end
        
        it 'returns only the first numeric value if there are several' do
          Variable.new('testing 1, 2, 3...').to_i.should == 1
        end
      end
    end

    describe '#to_f' do
      it 'returns zero by default' do
        Variable.new.to_f.should == 0.0
      end
      
      context 'when the value is numeric' do
        %w{ -23.2 -1.45 0.2 1.733 23 }.each do |value|
          it "returns the integer value (#{value})" do
            Variable.new(value).to_f.should == value.to_f
          end
        end
        
        it 'returns only the first numeric value if there are several' do
          Variable.new('testing 1, 2, 3...').to_f.should == 1.0
        end
        
        it 'works with dot and comma separators' do
          Variable.new('1,23').to_f.should == Variable.new('1.23').to_f
        end
      end
    end
    
    describe '#numeric?' do
      it 'returns false by default' do
        Variable.new.should_not be_numeric
      end

      context 'variable contains a number' do
        it 'returns true (string initialized)' do
          Variable.new('23').should be_numeric
          Variable.new('foo 23').should be_numeric
        end
        it 'returns true (integer initialized)' do
          Variable.new(23).should be_numeric
        end
      end 
      context 'variable does not contain a number' do
        it 'returns false for strings' do
          Variable.new('test').should_not be_numeric
        end
      end
    end
    
    describe '#strip_markup' do
      let(:greeting) { '<h1>hello<b> world</b></h1>' }
      it 'returns a string stripped of html tags' do
        Variable.new(greeting).strip_markup.should == 'hello world'
      end
      it 'does not alter the value itself' do
        v = Variable.new(greeting)
        v.strip_markup
        v.should == greeting
      end
    end

    describe '#strip_markup!' do
      let(:greeting) { '<h1>hello<b> world</b></h1>' }
      it 'strips of html tags' do
        v = Variable.new(greeting)
        v.strip_markup!
        v.should == 'hello world'
      end
    end
    
    
    describe 'sorting' do
    end
    
    describe '#to_json' do
    end
    
  end
end