module PogoStats
  module Stats
    class Medals < PogoStats::Stats::Base
      attr_accessor :collectors
      attr_accessor :jogger
      attr_accessor :scientist
      attr_accessor :breeder
      attr_accessor :backpacker
      attr_accessor :battle_girl
      attr_accessor :ace_trainer
      attr_accessor :youngster
      attr_accessor :pikachu_fan
      attr_accessor :fisherman
      attr_accessor :berry_master
      attr_accessor :gym_leader
      attr_accessor :champion
      attr_accessor :battle_legend
      attr_accessor :total_unique_unown

      def initialize(values)
        super

        self.collectors         = sanitise_number(:collectors)
        self.jogger             = sanitise_number(:jogger)
        self.scientist          = sanitise_number(:scientist)
        self.breeder            = sanitise_number(:breeder)
        self.backpacker         = sanitise_number(:backpacker)
        self.battle_girl        = sanitise_number(:battle_girl)
        self.ace_trainer        = sanitise_number(:ace_trainer)
        self.youngster          = sanitise_number(:youngster)
        self.pikachu_fan        = sanitise_number(:pikachu_fan)
        self.fisherman          = sanitise_number(:fisherman)
        self.berry_master       = sanitise_number(:berry_master)
        self.gym_leader         = sanitise_number(:gym_leader)
        self.champion           = sanitise_number(:champion)
        self.battle_legend      = sanitise_number(:battle_legend)
        self.total_unique_unown = sanitise_number(:total_unique_unown)
      end
    end
  end
end
