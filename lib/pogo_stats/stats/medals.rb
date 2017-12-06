module PogoStats
  module Stats
    class Medals
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

      attr_accessor :mapper

      def initialize(values)
        self.mapper    = PogoStats::Stats::Mapper

        self.collectors = values[mapper.map[:collectors]].delete(',').to_i
        self.jogger = values[mapper.map[:jogger]].delete(',').to_i
        self.scientist = values[mapper.map[:scientist]].delete(',').to_i
        self.breeder = values[mapper.map[:breeder]].delete(',').to_i
        self.backpacker = values[mapper.map[:backpacker]].delete(',').to_i
        self.battle_girl = values[mapper.map[:battle_girl]].delete(',').to_i
        self.ace_trainer = values[mapper.map[:ace_trainer]].delete(',').to_i
        self.youngster = values[mapper.map[:youngster]].delete(',').to_i
        self.pikachu_fan = values[mapper.map[:pikachu_fan]].delete(',').to_i
        self.fisherman = values[mapper.map[:fisherman]].delete(',').to_i
        self.berry_master = values[mapper.map[:berry_master]].delete(',').to_i
        self.gym_leader = values[mapper.map[:gym_leader]].delete(',').to_i
        self.champion = values[mapper.map[:champion]].delete(',').to_i
        self.battle_legend = values[mapper.map[:battle_legend]].delete(',').to_i
        self.total_unique_unown = values[mapper.map[:total_unique_unown]].delete(',').to_i
      end
    end
  end
end
