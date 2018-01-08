require 'spec_helper'

RSpec.describe TeamColourMatrix do
  describe '.verified_team' do
    subject { described_class }

    let(:rgb) { [0,0,255] }

    it 'a RGB value' do
      allow(TeamColourMatrix::Mystic)
        .to receive(:colours)
        .and_return([rgb])

      expect(subject.verified_team(rgb)).to eql('Mystic')
    end

    it 'raises an exception if a team is not found' do
      expect {
        subject.verified_team([0,0,0])
      }.to raise_error(TeamColourMatrix::TeamNotFound)
    end
  end
end
