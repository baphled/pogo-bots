require 'spec_helper'

RSpec.describe PogoStats::Competition do
  let(:raw_data) do
    [
      ["Yomi", "baphled", "Mystic", "baphled", "14/07/2016", "20/06/2017", "40", "", "39,511,435", "252", "249", "", "56,363", "3,208.1", "7,235", "4,240", "46,199", "8,515", "3,255", "323", "380", "216", "15,502", "13,971", "171", "251", "8", "25", "23", "304", "16", "18"],
      ["Jeff", "blogs", "Valor", "blogs", "14/07/2016", "20/06/2017", "20", "", "9,511", "22", "249", "", "563", "38.1", "235", "240", "199", "515", "25", "23", "80", "16", "02", "971", "171", "251", "8", "25", "23", "304", "16", "18"],
      [],
    ]
  end

  let(:datasource) { PogoStats::Spreadsheet.new(values: raw_data).entries }

  let(:players) { PogoStats::ValueObject::Stats.new(datasource) }

  subject { described_class }

  context 'instantiated' do
    subject { described_class.new(players: players, state: 'start', statistic: :breeder) }

    it 'has a players' do
      expect(subject).to respond_to(:players)
    end

    it 'has a state' do
      expect(subject).to respond_to(:state)
    end

    it 'has a statistic' do
      expect(subject).to respond_to(:statistic)
    end
  end

  it 'must have a valid statistic' do
    expect {
      subject.new(players: players, state: 'start', statistic: :foo)
    }.to raise_error(PogoStats::Stats::InvalidComparison)
  end

  it 'raises an error when invalid' do
    expect {
      subject.new(players: players, state: 'foo', statistic: :breeder)
    }.to raise_error(PogoStats::InvalidCompetitionState)
  end

  context 'valid states' do
    it 'can take start' do
      expect {
        subject.new(players: players, state: :start, statistic: :breeder)
      }.not_to raise_error(PogoStats::InvalidCompetitionState)
    end

    it 'can take stop' do
      expect {
        subject.new(players: players, state: :stop, statistic: :breeder)
      }.not_to raise_error(PogoStats::InvalidCompetitionState)
    end

    it 'can take cancel' do
      expect {
        subject.new(players: players, state: :cancel, statistic: :breeder)
      }.not_to raise_error(PogoStats::InvalidCompetitionState)
    end

    it 'can take running' do
      expect {
        subject.new(players: players, state: :running, statistic: :breeder)
      }.not_to raise_error(PogoStats::InvalidCompetitionState)
    end
  end

  describe '#start' do
    subject { described_class.new(players: players, state: :start, statistic: :breeder) }

    let(:player) { double(:player, params) }

    let(:params) do
      {
        discord_tag: 'baphled',
        player_tag: 'baphled',
        statistic: 'breeder',
        initial_value: 4240,
      }
    end

    it 'collects all the players statistic' do
      allow(PogoStats::ValueObject::Stats)
        .to receive(:new)
        .and_return(players)
      
      expect(players)
        .to receive(:entries)
        .and_return([])

      subject.start
    end

    it 'stores the players information' do
      expect(PogoStats::Models::PlayerStatistic)
        .to receive(:create!)
        .and_return(true)
        .exactly(:twice)

      subject.start
    end

    context 'competition for statistic already exists' do
      let(:expected) do
        "Competition already started"
      end

      it 'will not start a new competition' do
        allow(PogoStats::Models::PlayerStatistic)
          .to receive(:find_by)
          .and_return([double(:player_statistic)])

        expect(subject.start).to eql(expected)
      end
    end
  end

  describe '#stop' do
    subject { described_class.new(players: players, state: :start, statistic: :total_xp) }

    let(:raw_data) do
      [
        ["Yomi", "baphled", "Mystic", "baphled", "14/07/2016", "20/06/2017", "40", "", "39,511,935", "252", "249", "", "56,363", "3,208.1", "7,235", "4,240", "46,199", "8,515", "3,255", "323", "380", "216", "15,502", "13,971", "171", "251", "8", "25", "23", "304", "16", "18"],
        ["Jeff", "blogs", "Valor", "blogs", "14/07/2016", "20/06/2017", "20", "", "209,511", "22", "249", "", "563", "38.1", "235", "240", "199", "515", "25", "23", "80", "16", "02", "971", "171", "251", "8", "25", "23", "304", "16", "18"],
        [],
      ]
    end

    let(:expected) do
      """
      Congratulations #{winner.discord_tag}, you're the winner of the total_xp competition

      With a total of 200000

      Competition has now ended!
      """
    end

    let(:winner) { double(:player, discord_tag: "blogs") }

    before :each do
      PogoStats::Models::PlayerStatistic.create(
        discord_tag:     'baphled',
        player_tag:      'baphled',
        statistic:       'total_xp',
        initial_value:   39_511_435
      )
      PogoStats::Models::PlayerStatistic.create(
        discord_tag:     'blogs',
        player_tag:      'blogs',
        statistic:       'total_xp',
        initial_value:   9_511
      )
      subject.start
    end

    it 'calculates the amount made since the start'

    it 'returns the winner' do
      expect(subject.stop).to eql(expected)
    end

    context 'player no longer in league' do
      it 'does not try to find the players statistic'
      it 'players final value is zero'
    end

    context 'new player added to the league' do
      it 'looks for the player'
      it 'does not set a final_value'
      it 'players final value is zero'
    end
  end

  describe '#cancel' do
    subject { described_class.new(players: players, state: :start, statistic: :breeder) }

    let(:expected) do
      "The breeder competition has been cancelled"
    end

    it 'removes the competition' do
      expect(PogoStats::Models::PlayerStatistic)
        .to receive(:destroy)
        .and_return([double(id: 1)])

      subject.cancel
    end

    it 'returns a message' do
      expect(subject.cancel).to eql(expected)
    end
  end

  describe '#running' do
    subject { described_class.new(players: players, state: :start, statistic: :breeder) }

    let(:expected) do
      "Currently have 2 in the current competition"
    end

    it 'returns the current competition' do
      subject.start

      expect(subject.running).to eql(expected)
    end
  end
end
