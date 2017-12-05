require 'spec_helper'

RSpec.describe PogoStats::Stats::Medals do
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

  it 'stores the player\'s collectors medal'
  it 'stores the player\'s jogger medal'
  it 'stores the player\'s scientist medal'
  it 'stores the player\'s breeder medal'
  it 'stores the player\'s backpacker medal'
  it 'stores the player\'s battle girl medal'
  it 'stores the player\'s ace trainer medal'
  it 'stores the player\'s youngster medal'
  it 'stores the player\'s pikachu fan medal'
  it 'stores the player\'s fisherman medal'
  it 'stores the player\'s berry_master medal'
  it 'stores the player\'s gym_leader medal'
  it 'stores the player\'s champion medal'
  it 'stores the player\'s battle_legend medal'
  it 'stores the player\'s total_unique_unown medal'
end
