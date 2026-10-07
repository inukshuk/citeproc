require 'spec_helper'

describe 'CiteProc' do

  describe '.process' do
    it 'is defined' do
      expect(CiteProc).to respond_to(:process)
    end
  end

  describe '.romanesque_start?' do
    it 'returns true for strings starting with a letter of a space-separated script' do
      ['and', '&', 'und', 'και', 'и', 'עם'].each do |string|
        expect(CiteProc.romanesque_start?(string)).to be(true), string
      end
    end

    it 'returns false for other strings' do
      ['等', 'と', "ו\u2008", '', nil].each do |string|
        expect(CiteProc.romanesque_start?(string)).to be(false), string.inspect
      end
    end
  end

  describe '.boolean' do
    it 'returns true for xsd:boolean true values' do
      ['true', '1', true].each do |value|
        expect(CiteProc.boolean(value)).to be(true), value.inspect
      end
    end

    it 'returns false for xsd:boolean false values' do
      ['false', '0', false].each do |value|
        expect(CiteProc.boolean(value, true)).to be(false), value.inspect
      end
    end

    it 'returns the default for missing or invalid values' do
      [nil, '', 'TRUE', 'yes'].each do |value|
        expect(CiteProc.boolean(value)).to be(false), value.inspect
        expect(CiteProc.boolean(value, true)).to be(true), value.inspect
      end
    end
  end

end

