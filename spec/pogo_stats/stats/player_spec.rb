RSpec.describe PogoStats::Stats::Player do
  let(:entry) do
    ["Yomi",
     "baphled",
     "Mystic",
     "baphled",
     "14/07/2016",
     "20/06/2017",
     "40",
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
    expect(subject.total_xp).to eql('39,511,435')
  end

  it 'stores the pokemon the user has seen' do
    expect(subject.pokemon_seen).to eql('252')
  end

  it 'stores the pokemon the user has caught' do
    expect(subject.pokemon_caught).to eql('249')
  end

  describe '#attributes' do
    it 'returns a hash of attributes'
  end

  describe '#to_h' do
    it 'returns the expected hash'
  end
end
