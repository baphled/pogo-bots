require 'spec_helper'

RSpec.describe PogoStats::Stats::Overall do
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
     "18",
     "06/12/2017",
    ]
  end

  subject { described_class.new(entry) }

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
end
