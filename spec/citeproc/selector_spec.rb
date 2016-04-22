require 'spec_helper'

module CiteProc

  describe Selector do

    let(:select_books) { Selector.new(:all => { :type => :book }) }

    it { is_expected.not_to be nil }
    it { is_expected.to be_empty }


    it 'should have no skip_condtions by default' do
      expect(Selector.new.skip_conditions).to be_empty
    end

    it 'should have no condtions by default' do
      expect(Selector.new.conditions).to be_empty
    end

    describe 'constructing' do

      %w{ all none any skip }.each do |matcher|
        it "accepts the ruby style matcher '#{matcher}'" do
          expect(Selector.new(matcher => {})).not_to be nil
        end
      end

      %w{ include exclude select quash }.each do |matcher|
        it "accepts the citeproc-js style matcher '#{matcher}'" do
          expect(Selector.new(matcher => {})).not_to be nil
        end
      end

      # it 'fails if the hash contains more than two elements'
      # it 'fails if the hash contains unknown keys'

      # it 'accepts a citeproc json style hash'

      it 'accepts a json object (select)' do
        expect(Selector.new(
          "select" => [
            {
              "field" => "type",
              "value" => "book"
            },
            {  "field" => "categories",
               "value" => "1990s"
            }
          ]
        ).conditions.size).to eq(2)
      end
    end

    describe '#to_proc' do
    end

    describe '#to_citeproc' do

      it 'returns nil by default' do
        expect(Selector.new.to_citeproc).to be nil
      end

      it 'converts all matcher to select' do
        expect(Selector.new(:all => { :a => 'b' }).to_citeproc).to eq({ 'select' => [{ 'field' => 'a', 'value' => 'b' }]})
      end

      it 'converts any matcher to include' do
        expect(Selector.new(:any => { :a => 'b' }).to_citeproc).to eq({ 'include' => [{ 'field' => 'a', 'value' => 'b' }]})
      end

      it 'converts none matcher to exclude' do
        expect(Selector.new(:none => { :a => 'b' }).to_citeproc).to eq({ 'exclude' => [{ 'field' => 'a', 'value' => 'b' }]})
      end
    end

    describe '#matches?' do
      it 'always matches by default' do
        expect(Selector.new.matches?(nil)).to be_truthy
      end
    end

    describe '#skip?' do
      it 'never skips when by default' do
        expect(Selector.new.skip?(nil)).to be_falsey
      end
    end
  end

end
