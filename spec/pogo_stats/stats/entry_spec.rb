require 'spec_helper'

RSpec.describe PogoStats::Stats::Entry do
  let(:player) { double }
  let(:medals) { double }
  let(:overall) { double }

  subject { described_class.new(player: player, medals: medals, overall: overall) }

  it 'has a player' do
    expect(subject).to respond_to(:player)
  end

  it 'has a medals' do
    expect(subject).to respond_to(:medals)
  end

  it 'has a overall stats' do
    expect(subject).to respond_to(:overall)
  end
end
