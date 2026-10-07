require 'spec_helper'

module CiteProc
  describe 'CiteProc::Number' do
    describe '.pluralize?' do
      it 'returns true for lists and ranges' do
        ['1-2', '4–6', 'i-ix', 'N110-N115', '213 and 235', '213 & 235', '1, 3', '23f'].each do |value|
          expect(CiteProc::Number.pluralize?(value)).to be(true), value
        end
      end

      it 'returns false for single values and escaped hyphens' do
        ['23', 'iv', 'Michaelson-Morely', '3\\-B', '327\\-30'].each do |value|
          expect(CiteProc::Number.pluralize?(value)).to be(false), value
        end
      end
    end

    describe '.romanize' do
      it 'converts numbers to roman numerals' do
        expect(Number.romanize(1)).to eq('i')
        expect(Number.romanize(4)).to eq('iv')
        expect(Number.romanize(1994)).to eq('mcmxciv')
        expect(Number.romanize(4999)).to eq('mmmmcmxcix')
      end

      it 'accepts strings' do
        expect(Number.romanize('12')).to eq('xii')
      end

      it 'returns numbers out of range unchanged' do
        expect(Number.romanize(0)).to eq(0)
        expect(Number.romanize(-3)).to eq(-3)
        expect(Number.romanize(5000)).to eq(5000)
        expect(Number.romanize(12000)).to eq(12000)
      end
    end
  end
end
