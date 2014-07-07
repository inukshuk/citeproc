require 'spec_helper'

describe 'CiteProc' do

  describe '.process' do
    it 'is defined' do
      expect(CiteProc).to respond_to(:process)
    end
  end

end

