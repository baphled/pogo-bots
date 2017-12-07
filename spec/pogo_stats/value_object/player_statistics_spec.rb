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
      start_date: '14/06/2016',
    )
  end

  let(:medals) do
    double(
      collectors: 1,
      jogger: 10_000,
      scientist: 25,
      breeder: 25_000,
      backpacker: 45,
      battle_girl: 45_000,
      youngster: 200,
      pikachu_fan: 500,
      fisherman: 111,
      berry_master: 11_100,
      gym_leader: 13971,
      ace_trainer: 234,
      champion: 171,
      battle_legend: 251,
      total_unique_unown: 8,
    )
  end

  let(:overall) do
    double(
      total_perfect_pokemon: 25,
      total_unique_perfect_pokemon: 23,
      total_gyms: 304,
      total_golds_gyms: 16,
      total_golds_pokemon_per_type: 18,
      last_updated: '06/12/2017',
    )
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

  it 'has a start_date' do
    expect(subject.start_date).to eql('14/06/2016')
  end

  it 'has ace trainer' do
    expect(subject.ace_trainer).to eql(234)
  end

  it 'has collectors' do
    expect(subject.collectors).to eql(1)
  end

  it 'has jogger' do
    expect(subject.jogger).to eql(10_000)
  end

  it 'has scientist' do
    expect(subject.scientist).to eql(25)
  end

  it 'has breeder' do
    expect(subject.breeder).to eql(25_000)
  end

  it 'has backpacker' do
    expect(subject.backpacker).to eql(45)
  end

  it 'has battle_girl' do
    expect(subject.battle_girl).to eql(45_000)
  end

  it 'has youngster' do
    expect(subject.battle_girl).to eql(45_000)
  end

  it 'has pikachu_fan' do
    expect(subject.pikachu_fan).to eql(500)
  end

  it 'has fisherman' do
    expect(subject.fisherman).to eql(111)
  end

  it 'has berry_master' do
    expect(subject.berry_master).to eql(11_100)
  end

  it 'stores the gym_leader medal' do
    expect(subject.gym_leader).to eql(13971)
  end

  it 'stores the champion medal' do
    expect(subject.champion).to eql(171)
  end

  it 'stores the battle_legend medal' do
    expect(subject.battle_legend).to eql(251)
  end

  it 'stores the total_unique_unown medal' do
    expect(subject.total_unique_unown).to eql(8)
  end

  it 'stores the total_perfect_pokemon' do
    expect(subject.total_perfect_pokemon).to eql(25)
  end

  it 'stores the total_unique_perfect_pokemon' do
    expect(subject.total_unique_perfect_pokemon).to eql(23)
  end

  it 'stores the total_gyms' do
    expect(subject.total_gyms).to eql(304)
  end

  it 'stores the total_golds_gyms' do
    expect(subject.total_golds_gyms).to eql(16)
  end

  it 'stores the total_golds_pokemon_per_type' do
    expect(subject.total_golds_pokemon_per_type).to eql(18)
  end

  it 'stores the last_updated' do
    expect(subject.last_updated).to eql('06/12/2017')
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
