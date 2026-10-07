require 'spec_helper'

module CiteProc
  describe 'CiteProc::Number' do
    describe '.format_page_range' do
      it 'supports "minimal" format' do
        expect(CiteProc::Number.format_page_range('42-45', 'minimal')).to eq('42–5')
        expect(CiteProc::Number.format_page_range('321-328', 'minimal')).to eq('321–8')
        expect(CiteProc::Number.format_page_range('2787-2816', 'minimal')).to eq('2787–816')
        expect(CiteProc::Number.format_page_range('8-45', 'minimal')).to eq('8–45')

        expect(CiteProc::Number.format_page_range('42-5', 'minimal')).to eq('42–5')
        expect(CiteProc::Number.format_page_range('321-28', 'minimal')).to eq('321–8')
        expect(CiteProc::Number.format_page_range('321-8', 'minimal')).to eq('321–8')
        expect(CiteProc::Number.format_page_range('2787-816', 'minimal')).to eq('2787–816')
      end

      it 'supports "minimal-two" format' do
        expect(CiteProc::Number.format_page_range('42-45', 'minimal-two')).to eq('42–45')
        expect(CiteProc::Number.format_page_range('321-328', 'minimal-two')).to eq('321–28')
        expect(CiteProc::Number.format_page_range('2787-2816', 'minimal-two')).to eq('2787–816')
        expect(CiteProc::Number.format_page_range('2-5', 'minimal-two')).to eq('2–5')
        expect(CiteProc::Number.format_page_range('2-402', 'minimal-two')).to eq('2–402')

        expect(CiteProc::Number.format_page_range('42-5', 'minimal-two')).to eq('42–45')
        expect(CiteProc::Number.format_page_range('321-28', 'minimal-two')).to eq('321–28')
        expect(CiteProc::Number.format_page_range('321-8', 'minimal-two')).to eq('321–28')
        expect(CiteProc::Number.format_page_range('2787-816', 'minimal-two')).to eq('2787–816')
      end

      it 'supports "expanded" format' do
        expect(CiteProc::Number.format_page_range('42-45', 'expanded')).to eq('42–45')
        expect(CiteProc::Number.format_page_range('321-328', 'expanded')).to eq('321–328')
        expect(CiteProc::Number.format_page_range('2787-2816', 'expanded')).to eq('2787–2816')
        expect(CiteProc::Number.format_page_range('2-5', 'expanded')).to eq('2–5')
        expect(CiteProc::Number.format_page_range('2-402', 'expanded')).to eq('2–402')

        expect(CiteProc::Number.format_page_range('42-5', 'expanded')).to eq('42–45')
        expect(CiteProc::Number.format_page_range('321 - 28', 'expanded')).to eq('321–328')
        expect(CiteProc::Number.format_page_range('321 -8', 'expanded')).to eq('321–328')
        expect(CiteProc::Number.format_page_range('2787- 816', 'expanded')).to eq('2787–2816')
      end

      it 'supports "chicago" format' do
        expect(CiteProc::Number.format_page_range('3-10; 71-72', 'chicago')).to eq('3–10; 71–72')
        expect(CiteProc::Number.format_page_range('100-104; 600-613; 1100-23', 'chicago')).to eq('100–104; 600–613; 1100–1123')
        expect(CiteProc::Number.format_page_range('107-08; 505-517; 1002-006', 'chicago')).to eq('107–8; 505–17; 1002–6')
        expect(CiteProc::Number.format_page_range('321-325; 415-532; 11564-11568; 13792-803', 'chicago')).to eq('321–25; 415–532; 11564–68; 13792–803')
        expect(CiteProc::Number.format_page_range('1496-504; 2787-2816', 'chicago')).to eq('1496–1504; 2787–2816')
      end

      it 'supports "chicago-16" format' do
        expect(CiteProc::Number.format_page_range('1496-1500; 1087-89; 11564-11615', 'chicago-16')).to eq('1496–500; 1087–89; 11564–615')
        expect(CiteProc::Number.format_page_range('1100-13; 101-108; 321-8', 'chicago-16')).to eq('1100–1113; 101–8; 321–28')
      end

      it 'formats multiple page ranges' do
        expect(CiteProc::Number.format_page_range('42-45 and 57; 81-3 & 123-4', 'minimal-two')).to eq('42–45 and 57; 81–83 & 123–24')
      end

      it 'formats page ranges with the same prefix' do
        expect(CiteProc::Number.format_page_range('N110 - N5', 'expanded')).to eq('N110–N115')
        expect(CiteProc::Number.format_page_range('n11564-n1568', 'chicago')).to eq('n11564–68')
        expect(CiteProc::Number.format_page_range('8n11564-8n1568', 'minimal')).to eq('8n11564–8')
      end

      it 'does not format page ranges with different prefixes' do
        expect(CiteProc::Number.format_page_range('N110 - 5', 'expanded')).to eq('N110-5')
        expect(CiteProc::Number.format_page_range('n11564-1568', 'minimal')).to eq('n11564-1568')
        expect(CiteProc::Number.format_page_range('123N110 - N5, 456K200 - 99', 'expanded')).to eq('123N110-N5, 456K200-99')
      end

      it 'uses the range delimiter for roman numerals' do
        expect(CiteProc::Number.format_page_range('xxv-xxviii', 'chicago-16')).to eq('xxv–xxviii')
        expect(CiteProc::Number.format_page_range('i-ix', nil)).to eq('i–ix')
      end

      it 'does not format words or escaped hyphens' do
        expect(CiteProc::Number.format_page_range('Michaelson-Morely', nil)).to eq('Michaelson-Morely')
        expect(CiteProc::Number.format_page_range('327\\-30', 'expanded')).to eq('327-30')
      end
    end

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
