require 'spec_helper'

describe 'CiteProc' do

  describe '.process' do
    it 'is defined' do
      CiteProc.should respond_to(:process)
    end
  end

end

