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
     "18"
    ]
  end

  subject { described_class.new(entry) }

  it 'stores the player\'s total_perfect_pokemon'
  it 'stores the player\'s total_unique_perfect_pokemon'
  it 'stores the player\'s total_gyms'
  it 'stores the player\'s total_golds_gyms'
  it 'stores the player\'s total_golds_pokemon_per_type'
  it 'stores the player\'s last_updated'
end
