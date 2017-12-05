require 'spec_helper'

RSpec.describe PogoStats::Stats::Mapper do
  describe '.map' do
    it 'can not be changed' do
      expect{ 
        subject.map = ''
      }.to raise_error
    end
  end
end
