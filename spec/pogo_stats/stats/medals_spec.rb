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
     "18",
     "06/12/2017",
    ]
  end

  subject { described_class.new(entry) }

  it 'stores the collectors medal' do
    expect(subject.collectors).to eql(56363)
  end

  it 'stores the jogger medal' do
    expect(subject.jogger).to eql(3208)
  end

  it 'stores the scientist medal' do
    expect(subject.scientist).to eql(7235)
  end

  it 'stores the breeder medal' do
    expect(subject.breeder).to eql(4240)
  end

  it 'stores the backpacker medal' do
    expect(subject.backpacker).to eql(46199)
  end

  it 'stores the battle girl medal' do
    expect(subject.battle_girl).to eql(8515)
  end

  it 'stores the ace trainer medal' do
    expect(subject.ace_trainer).to eql(3255)
  end

  it 'stores the youngster medal' do
    expect(subject.youngster).to eql(323)
  end

  it 'stores the pikachu fan medal' do
    expect(subject.pikachu_fan).to eql(380)
  end

  it 'stores the fisherman medal' do
    expect(subject.fisherman).to eql(216)
  end

  it 'stores the berry_master medal' do
    expect(subject.berry_master).to eql(15502)
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
end
