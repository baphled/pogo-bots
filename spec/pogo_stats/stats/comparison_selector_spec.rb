require 'spec_helper'

RSpec.describe PogoStats::Stats::ComparisonSelector do
  describe '.find' do
    subject { described_class }

    it 'can compare a users total xp' do
      expect(subject.find(:total_xp)).to eql({type: :total_xp, postfix: 'XP'})
    end

    it 'can compare a users collectors' do
      expect(subject.find(:collectors)).to eql({type: :collectors, postfix: 'Caught Pokemon'})
    end
  end
end
