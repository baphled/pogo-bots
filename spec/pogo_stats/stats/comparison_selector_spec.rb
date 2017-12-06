require 'spec_helper'

RSpec.describe PogoStats::Stats::ComparisonSelector do
  describe '.find' do
    subject { described_class }

    it 'can compare a users total xp' do
      expect(subject.find(:total_xp)).to eql({type: :total_xp, postfix: 'XP'})
    end

    it 'can compare a users collectors medals' do
      expect(subject.find(:collectors)).to eql({type: :collectors, postfix: 'Caught Pokemon'})
    end

    it 'can compare a users jogger medals' do
      expect(subject.find(:jogger)).to eql({type: :jogger, postfix: 'Distance walked'})
    end

    it 'can compare a users scientist medals' do
      expect(subject.find(:scientist)).to eql({type: :scientist, postfix: 'Pokemon Evolved'})
    end

    it 'can compare a users breeder medals' do
      expect(subject.find(:breeder)).to eql({type: :breeder, postfix: 'Pokemon Hatched'})
    end

    it 'can compare a users backpacker medals' do
      expect(subject.find(:backpacker)).to eql({type: :backpacker, postfix: 'Pokestops Visited'})
    end

    it 'can compare a users battle girl medals' do
      expect(subject.find(:battle_girl)).to eql({type: :battle_girl, postfix: 'Gym Battles'})
    end

    it 'can compare a users youngster medals' do
      expect(subject.find(:youngster)).to eql({type: :youngster, postfix: 'Tiny Rattata Caught'})
    end
    it 'can compare a users pikachu fan medals' do
      expect(subject.find(:pikachu_fan)).to eql({type: :pikachu_fan, postfix: 'Pikachu Caught'})
    end

    it 'can compare a users fisherman medals' do
      expect(subject.find(:fisherman)).to eql({type: :fisherman, postfix: 'Big Magikarp Caught'})
    end

    it 'can compare a users berry master medals' do
      expect(subject.find(:berry_master)).to eql({type: :berry_master, postfix: 'Pokemon Berried'})
    end

    it 'can compare a users gym leader medals' do
      expect(subject.find(:gym_leader)).to eql({type: :gym_leader, postfix: 'Hours Defending Gyms'})
    end

    it 'can compare a users champion medals' do
      expect(subject.find(:champion)).to eql({type: :champion, postfix: 'Raids Won'})
    end

    it 'can compare a users battle legend medals' do
      expect(subject.find(:battle_legend)).to eql({type: :battle_legend, postfix: 'Legenday Raids Won'})
    end

    it 'can compare a users total unique unown medals' do
      expect(subject.find(:total_unique_unown)).to eql({type: :total_unique_unown, postfix: 'Unique Unowns Caught'})
    end

    it 'can compare a users total pokemon type gold medals' do
      expect(subject.find(:total_golds_pokemon_per_type)).to eql({type: :total_golds_pokemon_per_type, postfix: 'Total Completed Pokemon Types'})
    end

    it 'can compare a users total perfect pokemon' do
      expect(subject.find(:total_perfect_pokemon)).to eql({type: :total_perfect_pokemon, postfix: 'Total Perfect Pokemon'})
    end

    it 'can compare a users total unique perfect pokemon' do
      expect(subject.find(:total_unique_perfect_pokemon)).to eql({type: :total_unique_perfect_pokemon, postfix: 'Total Unique Perfect Pokemon'})
    end

    it 'can compare a users total gyms' do
      expect(subject.find(:total_gyms)).to eql({type: :total_gyms, postfix: 'Total Gyms Visited'})
    end

    it 'can compare a users total gold gyms' do
      expect(subject.find(:total_golds_gyms)).to eql({type: :total_golds_gyms, postfix: 'Total Gold Gyms Held'})
    end
  end
end
