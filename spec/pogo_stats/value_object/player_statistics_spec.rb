require 'spec_helper'

RSpec.describe PogoStats::ValueObject::PlayerStatistics do
  let(:player) do
    double(
      name: 'Yomi',
      discord_tag: 'baphled',
      player_tag: 'baphled',
      team: 'Mystic',
      current_level: 40,
      total_xp: 40_000_000,
      pokemon_seen: 249,
      pokemon_caught: 252,
      start_date: '14/07/2016',
    )
  end

  let(:medals) do
    double(
      collectors: 1
    )
  end

  let(:overall) do
    double()
  end

  let(:entry) do
    double(player: player, medals: medals, overall: overall)
  end

  subject { described_class.new(entry) }

  it 'has a name' do
    expect(subject.name).to eql('Yomi')
  end

  it 'has a discord_tag' do
    expect(subject.discord_tag).to eql('baphled')
  end

  it 'has a player_tag' do
    expect(subject.player_tag).to eql('baphled')
  end

  it 'has a team' do
    expect(subject.team).to eql('Mystic')
  end

  it 'has a start_date' do
    expect(subject.start_date).to eql('14/07/2016')
  end

  it 'has a current_level' do
    expect(subject.current_level).to eql(40)
  end

  it 'has a total_xp' do
    expect(subject.total_xp).to eql(40_000_000)
  end

  it 'has a pokemon_seen' do
    expect(subject.pokemon_seen).to eql(249)
  end

  it 'has a pokemon_caught' do
    expect(subject.pokemon_caught).to eql(252)
  end

  it 'has collectors' do
    expect(subject.collectors).to eql(1)
  end

  describe '#new' do
    subject { described_class }

    it 'takes an entry' do
      expect {
        subject.new(entry)
      }.not_to raise_error
    end
  end
end
