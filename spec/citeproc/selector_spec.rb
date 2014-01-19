require 'spec_helper'

module CiteProc

  describe Selector do

    let(:select_books) { Selector.new(:all => { :type => :book }) }

    it { should_not be nil }
    it { should be_empty }


    it 'should have no skip_condtions by default' do
      Selector.new.skip_conditions.should be_empty
    end

    it 'should have no condtions by default' do
      Selector.new.conditions.should be_empty
    end

    describe 'constructing' do

      %w{ all none any skip }.each do |matcher|
        it "accepts the ruby style matcher '#{matcher}'" do
          Selector.new(matcher => {}).should_not be nil
        end
      end

      %w{ include exclude select quash }.each do |matcher|
        it "accepts the citeproc-js style matcher '#{matcher}'" do
          Selector.new(matcher => {}).should_not be nil
        end
      end

      # it 'fails if the hash contains more than two elements'
      # it 'fails if the hash contains unknown keys'

      it 'accepts a citeproc json style hash'
      # it 'accepts a json object (select)' do
      #         Selector.new(
      #            "select" => [
      #               {
      #                  "field" => "type",
      #                  "value" => "book"
      #               },
      #               {  "field" => "categories",
      #                   "value" => "1990s"
      #               }
      #            ]
      #         ).conditions.should have(2).items
      #       end

    end

    describe '#to_proc' do
    end

    describe '#to_citeproc' do

      it 'returns nil by default' do
        Selector.new.to_citeproc.should be nil
      end

      it 'converts all matcher to select' do
        Selector.new(:all => { :a => 'b' }).to_citeproc.should == { 'select' => [{ 'field' => 'a', 'value' => 'b' }]}
      end

      it 'converts any matcher to include' do
        Selector.new(:any => { :a => 'b' }).to_citeproc.should == { 'include' => [{ 'field' => 'a', 'value' => 'b' }]}
      end

      it 'converts none matcher to exclude' do
        Selector.new(:none => { :a => 'b' }).to_citeproc.should == { 'exclude' => [{ 'field' => 'a', 'value' => 'b' }]}
      end


    end

  end

end
