require 'spec_helper'

RSpec.describe PogoStats::Stats::Player do
  let(:entry) do
    ["Yomi",
     "baphled",
     "Mystic",
     "baphled",
     "14/07/2016",
     "20/06/2017",
     "20",
     "",
     "39,511,435",
     "252",
     "249",
     "",
     "56,363",
     "3,208.1",
     "7,235",
     "4,240",
     "46,199",
     "8,515",
     "3,255",
     "323",
     "380",
     "216",
     "15,502",
     "13,971",
     "171",
     "251",
     "8",
     "25",
     "23",
     "304",
     "16",
     "18"
    ]
  end

  subject { described_class.new(entry) }

  it 'stores the users name' do
    expect(subject.name).to eql('Yomi')
  end

  it 'stores the users team' do
    expect(subject.team).to eql('Mystic')
  end

  it 'stores the users discord name' do
    expect(subject.discord_tag).to eql('baphled')
  end

  it 'stores the users in-game name' do
    expect(subject.player_tag).to eql('baphled')
  end

  it 'stores the users start date' do
    expect(subject.start_date).to eql('14/07/2016')
  end

  it 'stores the users current level' do
    expect(subject.current_level).to eql('40')
  end

  it 'stores the users total XP' do
    expect(subject.total_xp).to eql(39_511_435)
  end

  it 'stores the pokemon the user has seen' do
    expect(subject.pokemon_seen).to eql('252')
  end

  it 'stores the pokemon the user has caught' do
    expect(subject.pokemon_caught).to eql('249')
  end

  describe '#top_players' do
    let(:second_entry) do
      ["Frodo",
       "Kibble",
       "Mystic",
       "Kibble",
       "14/07/2016",
       "20/06/2017",
       "40",
       "",
       "29,511,435",
       "251",
       "249",
       "",
       "96,363",
       "2,208.1",
       "5,235",
       "1,240",
       "26,199",
       "3,515",
       "1,255",
       "223",
       "580",
       "211",
       "12,502",
       "11,971",
       "121",
       "151",
       "4",
       "15",
       "13",
       "104",
       "16",
       "18"
      ]
    end

    let(:first_player) { described_class.new(entry) }

    let(:second_player) { described_class.new(second_entry) }

    let(:players) { [first_player, second_player] }

    subject { described_class }

    it 'requires a array of players' do
      expect {
        subject.top_players(players: players)
      }.not_to raise_error
    end

    it 'takes a number of players to return' do
      expect {
        subject.top_players(players: players, amount: 10)
      }.not_to raise_error
    end

    it 'returns the expected number of results' do
      expect(subject.top_players(players: players, amount: 1).count).to eql(1)
    end

    context 'comparable fields' do
      it 'can compare XP' do
        expect(subject.top_players(players: players, compare: :total_xp)).to eql([first_player, second_player])
      end

      it 'can compare level' do
        expect(subject.top_players(players: players, compare: :current_level)).to eql([second_player, first_player])
      end

      it 'can compare total gold gyms'

      it 'handles fields that can not be compared'
      it 'handles fields that do not exist'
    end
  end

  describe '#attributes' do
    it 'returns a hash of attributes'
  end

  describe '#to_h' do
    it 'returns the expected hash'
  end
end
