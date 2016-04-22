require 'spec_helper'

module CiteProc
  describe Variable do

    describe '.new' do
      it { is_expected.to be_an_instance_of(Variable) }

      it 'is empty by default' do
        expect(Variable.new).to be_empty
      end

      it 'equals an empty string (==) by default' do
        expect(Variable.new).to eq('')
      end

      it 'matches an empty pattern by default' do
        expect(Variable.new).to match(/^$/)
      end

      it 'accepts a string value' do
        expect(Variable.new('test')).to eq('test')
      end

      it 'accepts a numeric value' do
        expect(Variable.new(23)).to eq('23')
      end

      it 'accepts a floating point value' do
        expect(Variable.new(23.12)).to eq('23.12')
      end
    end

    describe '.fields' do
      it 'contains :names fields' do
        expect(Variable.fields[:names]).not_to be_empty
        expect(Variable.fields[:name]).to equal Variable.fields[:names]
      end

      it 'contains :date fields' do
        expect(Variable.fields[:date]).not_to be_empty
        expect(Variable.fields[:dates]).to equal Variable.fields[:date]
      end

      it 'contains :text fields' do
        expect(Variable.fields[:text]).not_to be_empty
      end

      it 'contains :number fields' do
        expect(Variable.fields[:numbers]).not_to be_empty
        expect(Variable.fields[:number]).not_to be_empty
      end

      it 'accepts either string or symbol input' do
        expect(Variable.fields[:names]).to equal Variable.fields['names']
      end
    end

    describe '.types' do
      it 'given a field name returns the corresponding type' do
        expect(Variable.types.values_at(:author, :issued, :abstract, :issue)).to eq([:names, :date, :text, :number])
      end

      it 'accepts either string or symbol input' do
        expect(Variable.types).to have_key(:author)
        expect(Variable.types['author']).to equal Variable.types[:author]
      end
    end

    describe '#to_s' do
      it 'displays the value' do
        expect(Variable.new('test').to_s).to eq('test')
      end
    end

    describe '#to_i' do
      it 'returns zero by default' do
        expect(Variable.new.to_i).to eq(0)
      end

      context 'when the value is numeric' do
        %w{ -23 -1 0 1 23 }.each do |value|
          it "returns the integer value (#{value})" do
            expect(Variable.new(value).to_i).to equal(value.to_i)
          end
        end

        it 'returns only the first numeric value if there are several' do
          expect(Variable.new('testing 1, 2, 3...').to_i).to eq(1)
        end
      end
    end

    describe '#to_f' do
      it 'returns zero by default' do
        expect(Variable.new.to_f).to eq(0.0)
      end

      context 'when the value is numeric' do
        %w{ -23.2 -1.45 0.2 1.733 23 }.each do |value|
          it "returns the integer value (#{value})" do
            expect(Variable.new(value).to_f).to eq(value.to_f)
          end
        end

        it 'returns only the first numeric value if there are several' do
          expect(Variable.new('testing 1, 2, 3...').to_f).to eq(1.0)
        end

        it 'works with dot and comma separators' do
          expect(Variable.new('1,23').to_f).to eq(Variable.new('1.23').to_f)
        end
      end
    end

    describe '#numeric?' do
      it 'returns false by default' do
        expect(Variable.new).not_to be_numeric
      end

      context 'variable contains a number' do
        it 'returns true (string initialized)' do
          expect(Variable.new('23')).to be_numeric
          expect(Variable.new('X23')).to be_numeric
          expect(Variable.new('23rd')).to be_numeric
        end
        it 'returns true (integer initialized)' do
          expect(Variable.new(23)).to be_numeric
        end
      end

      context 'variable does not contain a number' do
        it 'returns false for strings' do
          expect(Variable.new('test')).not_to be_numeric
        end
      end

      context 'variable contains numbers but is not numeric' do
        it 'returns false for strings' do
          expect(Variable.new('23rd test')).not_to be_numeric
          expect(Variable.new('23rd, 24th & 25th edition')).not_to be_numeric
        end
      end

      context 'variable contains multiple numbers' do
        it 'returns true for simple ranges' do
          expect(Variable.new('23-24')).to be_numeric
          expect(Variable.new('23 - 24')).to be_numeric
          expect(Variable.new('23-  24')).to be_numeric
        end

        it 'returns true for simple lists' do
          expect(Variable.new('23,24')).to be_numeric
          expect(Variable.new('23 , 24')).to be_numeric
          expect(Variable.new('23,  24')).to be_numeric
          expect(Variable.new('23 ,24')).to be_numeric
          expect(Variable.new('23 ,24,25 , 26, 27')).to be_numeric
        end

        it 'returns true for complex lists' do
          expect(Variable.new('23rd, 24th & 25th')).to be_numeric
          expect(Variable.new('X23, A2-49th & 25th & A1, B2')).to be_numeric
        end
      end
    end

    describe '#strip_markup' do
      let(:greeting) { '<h1>hello<b> world</b></h1>' }
      it 'returns a string stripped of html tags' do
        expect(Variable.new(greeting).strip_markup).to eq('hello world')
      end
      it 'does not alter the value itself' do
        v = Variable.new(greeting)
        v.strip_markup
        expect(v).to eq(greeting)
      end
    end

    describe '#strip_markup!' do
      let(:greeting) { '<h1>hello<b> world</b></h1>' }
      it 'strips of html tags' do
        v = Variable.new(greeting)
        v.strip_markup!
        expect(v).to eq('hello world')
      end
    end


    describe 'sorting' do
    end

    describe '#to_json' do
    end

  end
end
