module PogoStats
  module ValueObject
    class PlayerStatistics
      attr_accessor :name
      attr_accessor :discord_tag
      attr_accessor :player_tag
      attr_accessor :team

      attr_accessor :last_updated

      attr_accessor :start_date
      attr_accessor :level_40_date

      attr_accessor :current_level

      attr_accessor :pokemon_seen
      attr_accessor :pokemon_caught

      # Comparable attributes

      attr_accessor :total_xp

      attr_accessor :collectors
      attr_accessor :jogger
      attr_accessor :scientist
      attr_accessor :breeder
      attr_accessor :backpacker
      attr_accessor :battle_girl
      attr_accessor :youngster
      attr_accessor :pikachu_fan
      attr_accessor :fisherman
      attr_accessor :berry_master
      attr_accessor :gym_leader
      attr_accessor :ace_trainer
      attr_accessor :champion
      attr_accessor :battle_legend
      attr_accessor :total_unique_unown

      attr_accessor :total_perfect_pokemon
      attr_accessor :total_unique_perfect_pokemon
      attr_accessor :total_gyms
      attr_accessor :total_golds_gyms
      attr_accessor :total_golds_pokemon_per_type

      def initialize(entry)
        self.name = entry.player.name
        self.discord_tag = entry.player.discord_tag

        self.player_tag = entry.player.player_tag
        self.team = entry.player.team

        self.start_date = entry.player.start_date
        self.level_40_date = entry.player.level_40_date

        self.current_level = entry.player.current_level

        self.pokemon_seen = entry.player.pokemon_seen
        self.pokemon_caught = entry.player.pokemon_caught

        self.total_xp = entry.player.total_xp

        self.collectors = entry.medals.collectors
        self.jogger = entry.medals.jogger
        self.scientist = entry.medals.scientist
        self.breeder = entry.medals.breeder
        self.backpacker = entry.medals.backpacker
        self.battle_girl = entry.medals.battle_girl
        self.youngster = entry.medals.youngster
        self.pikachu_fan = entry.medals.pikachu_fan
        self.fisherman = entry.medals.fisherman
        self.berry_master = entry.medals.berry_master
        self.gym_leader = entry.medals.gym_leader
        self.ace_trainer = entry.medals.ace_trainer
        self.champion = entry.medals.champion
        self.battle_legend = entry.medals.battle_legend
        self.total_unique_unown = entry.medals.total_unique_unown

        self.total_perfect_pokemon = entry.overall.total_perfect_pokemon
        self.total_unique_perfect_pokemon = entry.overall.total_unique_perfect_pokemon
        self.total_gyms = entry.overall.total_gyms
        self.total_golds_gyms = entry.overall.total_golds_gyms
        self.total_golds_pokemon_per_type = entry.overall.total_golds_pokemon_per_type

        self.last_updated = entry.overall.last_updated
      end
    end
  end
end
