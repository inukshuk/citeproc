require 'spec_helper'

module CiteProc
  describe Date do

    describe Date::DateParts do
      it { is_expected.not_to be_nil }
      it { is_expected.to be_empty }

      describe 'sorting' do
        it 'treats [2003] as less than [2003,1]' do
          expect(Date::DateParts.new(2003)).to be < Date::DateParts.new(2003,1)
        end

        it 'treats [1992,9,23] as less than [1993,8,22]' do
          expect(Date::DateParts.new(1992,9,23)).to be < Date::DateParts.new(1993,8,22)
        end

        it 'treats [1992,9,23] as less than [1992,10,22]' do
          expect(Date::DateParts.new(1992,9,23)).to be < Date::DateParts.new(1992,10,22)
        end

        it 'treats [1992,9,23] as less than [1992,9,24]' do
          expect(Date::DateParts.new(1992,9,23)).to be < Date::DateParts.new(1992,9,24)
        end

        it 'treats [-50] as less than [-25]' do
          expect(Date::DateParts.new(-50)).to be < Date::DateParts.new(-25)
        end

        it 'treats [-50] as less than [-50,12]' do
          expect(Date::DateParts.new(-50)).to be < Date::DateParts.new(-50,12)
        end

        it 'treats [1994,1,23] as less than today' do
          expect(Date::DateParts.new(1994,1,23)).to be < ::Date.today
        end
      end

      describe '#dup' do
        let(:date) { Date::DateParts.new(1991,8,22) }

        it 'creates a copy that contains the same parts' do
          expect(date.dup.to_a).to eq([1991,8,22])
        end

        it 'does not return self' do
          expect(date.dup).not_to equal(date)
          expect(date.dup).to eq(date)
        end
      end

      describe '#update' do
        it 'accepts a hash' do
          expect(Date::DateParts.new.update(:month => 2, :year => 80).to_a).to eq([80,2,nil])
        end

        it 'accepts an array' do
          expect(Date::DateParts.new.update([80,2]).to_a).to eq([80,2,nil])
        end
      end

      describe '#strftime' do
        it 'formats the date parts according to the format string' do
          expect(Date::DateParts.new(1998,2,4).strftime('FOO %0m%0d%y')).to eq('FOO 020498')
        end
      end

      describe 'to_citeproc' do
        it 'returns an empty list by default' do
          expect(Date::DateParts.new.to_citeproc).to eq([])
        end

        it 'returns a list with the year if only the year is set' do
          expect(Date::DateParts.new(2001).to_citeproc).to eq([2001])
        end

        it 'supports zero parts' do
          expect(Date::DateParts.new(0,0).to_citeproc).to eq([0,0])
        end
      end

      describe '#open?' do
        it 'returns false by default' do
          expect(Date::DateParts.new).not_to be_open
        end

        it 'returns false for [1999,8,24]' do
          expect(Date::DateParts.new(1999, 8, 24)).not_to be_open
        end

        it 'returns true for [0]' do
          expect(Date::DateParts.new(0)).to be_open
        end
      end
    end


    let(:ad2k) { Date.create('date-parts' => [[2000]])}
    let(:may) { Date.create('date-parts' => [[2000, 5]])}
    let(:first_of_may) { Date.create('date-parts' => [[2000, 5, 1]])}

    let(:bc100) { Date.create('date-parts' => [[-100]]) }
    let(:bc50) { Date.create('date-parts' => [[-50]]) }
    let(:ad50) { Date.create('date-parts' => [[50]]) }
    let(:ad100) { Date.create('date-parts' => [[100]]) }

    it { is_expected.not_to be nil }

    it { is_expected.not_to be_numeric }

    describe '.new' do
      it 'accepts a hash as input' do
        expect(Date.new(:literal => 'Summer').to_s).to eq('Summer')
      end

      it 'accepts a hash as input and converts date parts' do
        expect(Date.new(:'date-parts' => [[2003,2]]).parts[0]).to be_a(Date::DateParts)
      end

      it 'accepts a fixnum and treats it as the year' do
        expect(Date.new(1666).year).to eq(1666)
      end

      it 'accepts a date' do
        expect(Date.new(::Date.new(1980,4)).month).to eq(4)
      end

      it 'accepts a date and creates date parts' do
        expect(Date.new(::Date.new(1980,4)).parts[0].to_citeproc).to eq([1980,4,1])
      end

      it 'is empty by default' do
        expect(Date.new).to be_empty
      end

      it 'accepts date strings' do
        expect(Date.new('2009-03-19').day).to eq(19)
      end

      it 'accepts JSON strings' do
        expect(Date.new('{ "date-parts": [[2001,1,19]]}').day).to eq(19)
      end

      it 'accepts date parts in an array' do
        expect(Date.new([2009,3]).month).to eq(3)
      end

      it 'accepts ranges as an array' do
        expect(Date.new([[2009],[2012]])).to be_range
      end

      it 'accepts year ranges' do
        expect(Date.new(2009..2012)).to be_range
      end

      it 'accepts exclusive date ranges' do
        expect(Date.new(::Date.new(2009) ... ::Date.new(2011)).end_date.year).to eq(2010)
      end

      it 'accepts inclusive date ranges' do
        expect(Date.new(::Date.new(2009) .. ::Date.new(2011)).end_date.year).to eq(2011)
      end

      it 'accepts EDTF date strings' do
        expect(Date.new('2009?-03-19')).to be_uncertain
      end

      it 'accepts EDTF intervals' do
        expect(Date.new('2009-03-19/2010-11-21').parts.map(&:to_citeproc)).to eq([[2009,3,19],[2010,11,21]])
      end
    end

		describe '.parse' do
			it 'returns nil by default' do
				expect(Date.parse('')).to be nil
				expect(Date.parse(nil)).to be nil
			end

			it 'parses date strings' do
				expect(Date.parse('2004-10-26').year).to eq(2004)
			end
		end

    describe '.create' do
      it 'should accept parameters and return a new instance' do
        expect(Date.create('date-parts' => [[2001, 1]]).year).to eq(2001)
      end
    end

    describe '#dup' do
      let(:date) { Date.new([1991,8]) }

      it 'creates a copy that contains the same parts' do
        expect(date.dup.parts.map(&:to_citeproc)).to eq([[1991,8]])
      end

      it 'copies uncertainty' do
        expect(date.dup).not_to be_uncertain
        expect(date.uncertain!.dup).to be_uncertain
      end

      it 'makes a deep copy of attributes' do
        expect { date.dup.uncertain! }.not_to change { date.uncertain? }
      end

      it 'makes a deep copy of date parts' do
        expect { date.dup.parts[0].update(:year => 2012) }.not_to change { date.year }
      end

      it 'does not return self' do
        expect(date.dup).not_to equal(date)
        expect(date.dup).to eq(date)
      end
    end

    describe 'literal dates' do
      it 'is not literal by default' do
        expect(Date.new).not_to be_literal
      end

      it 'is literal if it contains only a literal field' do
        expect(Date.create(:literal => 'foo')).to be_literal
      end

      it 'is literal if it contains a literal field' do
        expect(Date.create('date-parts' => [[2000]], :literal => 'foo')).to be_literal
      end
    end

    describe 'seasons' do
      it 'is no season by default' do
        expect(Date.new).not_to be_season
      end

      it 'is a season if contains only a season field' do
        expect(Date.new(:season => 'Winter')).to be_season
      end

      it 'is a season if contains a season field' do
        expect(Date.new(:'date-parts' => [[2001]], :season => 'Winter')).to be_season
      end
    end

    describe 'uncertain dates' do
      it 'are uncertain' do
        expect(Date.new({ 'date-parts' => [[-225]], 'circa' => '1' })).to be_uncertain
        expect(Date.new { |d| d.parts = [[-225]]; d.uncertain! }).not_to be_certain
      end

      describe '#(un)certain!' do
        it 'returns self' do
          expect(ad2k.uncertain!).to equal(ad2k)
          expect(ad2k.certain!).to equal(ad2k)
        end
      end
    end

    describe 'sorting' do
      it 'dates with more date-parts will come after those with fewer parts' do
        expect(ad2k < may  && may < first_of_may).to be true
      end

      it 'negative years are sorted inversely' do
        expect([ad50, bc100, bc50, ad100].sort.map(&:year)).to eq([-100, -50, 50, 100])
      end

      it 'can be compared to dates' do
        expect(ad50).to be < ::Date.new(50,2)
        expect(ad50).to be > ::Date.new(49)
      end
    end

    describe '#start_date' do
      it 'returns nil by default' do
        expect(Date.new.start_date).to be_nil
      end

      it 'returns a ruby date when date-parts are set' do
        expect(Date.new(1999).start_date.year).to eq(1999)
      end
    end

    describe '#end_date' do
      it 'returns nil by default' do
        expect(Date.new.end_date).to be_nil
      end

      it 'returns nil when there is a single date-parts set' do
        expect(Date.new(1312).end_date).to be_nil
      end

      it 'returns a ruby date when date-parts are a closed range' do
        expect(Date.new(1999..2000).end_date.year).to eq(2000)
      end
    end

    describe '#-@' do
      it 'inverts the year' do
        expect(-ad50).to eq(bc50)
      end
    end

    describe '#display' do
      it 'returns an empty string by default' do
        Date.new({}).to_s == ''
      end
    end

		describe 'b.c. and a.d.' do

			it 'the year 993 is a.d.' do
				expect(Date.new(993)).to be_ad
			end

			it 'the year 1000 is not a.d.' do
				expect(Date.new(1000)).not_to be_ad
			end

			it 'the year 993 is not b.c.' do
				expect(Date.new(993)).not_to be_bc
			end

			it 'the year 0 is a.d.' do
				expect(Date.new(0)).to be_ad
			end

			it 'the year 0 is not b.c.' do
				expect(Date.new(0)).not_to be_bc
			end

			it 'the year -33 is not a.d.' do
				expect(Date.new(-33)).not_to be_ad
			end

			it 'the year -33 is b.c.' do
				expect(Date.new(-33)).to be_bc
			end

			it 'today is not a.d.' do
				expect(Date.today).not_to be_ad
			end

			it 'today is not b.c.' do
				expect(Date.today).not_to be_bc
			end

			it 'the year 2000 is not a.d.' do
				expect(ad2k).not_to be_ad
			end

		end

		describe '#empty?' do
		  it 'returns true by default' do
		    expect(Date.new).to be_empty
		  end

		  it 'returns true when it contains no date parts' do
		    expect(Date.new({})).to be_empty
		  end

		  it 'returns false for today' do
		    expect(Date.today).not_to be_empty
		  end

		  it 'returns false for literal dates' do
		    expect(Date.new(:literal => 'foo')).not_to be_empty
		  end

		  it 'returns false for seasons' do
		    expect(Date.new(:season => 'Summer')).not_to be_empty
		  end
		end

    describe '#to_json' do
      it 'supports simple parts' do
        expect(Date.new(%w{2000 1 15}).to_json).to eq('{"date-parts":[[2000,1,15]]}')
      end

      it 'supports string parts' do
        expect(Date.new(['2000', '1', '15']).to_json).to eq('{"date-parts":[[2000,1,15]]}')
      end

      it 'supports integer parts' do
        expect(Date.new([2000, 1, 15]).to_json).to eq('{"date-parts":[[2000,1,15]]}')
      end

      it 'supports mixed parts' do
        expect(Date.new(['2000', 1, '15']).to_json).to eq('{"date-parts":[[2000,1,15]]}')
      end

      it 'supports negative years' do
        expect(Date.new(-200).to_json).to eq('{"date-parts":[[-200]]}')
      end

      it 'treats seasons as a strings' do
        expect(Date.create({:season => '1', 'date-parts' => [[1950]]}).to_json).to match(/"season":"1"/)
      end

      it 'supports seasons' do
        expect(Date.create({:season => 'Trinity', 'date-parts' => [[1975]]}).to_json).to match(/"season":"Trinity"/)
      end

      it 'supports string literals' do
        expect(Date.new(:literal => '13th century').to_json).to eq('{"literal":"13th century"}')
      end

      it 'supports raw strings' do
        expect(Date.new(:raw => '23 May 1955').to_json).to eq('{"date-parts":[[1955,5,23]]}')
      end

      it 'supports closed ranges' do
        expect(Date.new([[2000,11],[2000,12]]).to_json).to eq('{"date-parts":[[2000,11],[2000,12]]}')
      end

      it 'supports open ranges' do
        expect(Date.new([[2000,11],[0,0]]).to_json).to eq('{"date-parts":[[2000,11],[0,0]]}')
      end
    end

  end
end
