module PogoStats
  module Presenter
    class Player
      attr_reader :name
      attr_reader :team
      attr_reader :discord_tag
      attr_reader :player_tag
      attr_reader :start_date
      attr_reader :current_level
      attr_reader :total_xp

      attr_reader :ace_trainer
      attr_reader :collectors
      attr_reader :jogger
      attr_reader :scientist
      attr_reader :breeder
      attr_reader :backpacker
      attr_reader :battle_girl

      attr_reader :pokemon_seen
      attr_reader :pokemon_caught


      attr_reader :youngster
      attr_reader :pikachu_fan
      attr_reader :fisherman
      attr_reader :berry_master
      attr_reader :gym_leader
      attr_reader :champion
      attr_reader :battle_legend
      attr_reader :total_unique_unown

      attr_reader :total_perfect_pokemon
      attr_reader :total_unique_perfect_pokemon
      attr_reader :total_gyms
      attr_reader :total_golds_gyms
      attr_reader :total_golds_pokemon_per_type
      attr_reader :last_updated

      protected

      attr_writer :name
      attr_writer :team
      attr_writer :discord_tag
      attr_writer :player_tag
      attr_writer :start_date
      attr_writer :current_level
      attr_writer :total_xp
      attr_writer :ace_trainer
      attr_writer :collectors
      attr_writer :jogger
      attr_writer :scientist
      attr_writer :breeder
      attr_writer :backpacker
      attr_writer :battle_girl
      attr_writer :pokemon_seen
      attr_writer :pokemon_caught

      attr_writer :youngster
      attr_writer :pikachu_fan
      attr_writer :fisherman
      attr_writer :berry_master
      attr_writer :gym_leader
      attr_writer :champion
      attr_writer :battle_legend
      attr_writer :total_unique_unown

      attr_writer :total_perfect_pokemon
      attr_writer :total_unique_perfect_pokemon
      attr_writer :total_gyms
      attr_writer :total_golds_gyms
      attr_writer :total_golds_pokemon_per_type
      attr_writer :last_updated

      def initialize(player)
        self.name = player.name
        self.discord_tag = player.discord_tag

        self.player_tag = player.player_tag
        self.team = player.team

        self.start_date = player.start_date

        self.current_level = player.current_level
        self.total_xp = player.total_xp.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse

        self.pokemon_seen = player.pokemon_seen.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
        self.pokemon_caught = player.pokemon_caught.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse

        self.ace_trainer = player.ace_trainer.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
        self.collectors = player.collectors.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
        self.jogger = player.jogger.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
        self.breeder = player.breeder.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
        self.backpacker = player.backpacker.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
        self.battle_girl = player.battle_girl.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
        self.scientist = player.scientist.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse

        self.youngster = player.youngster.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
        self.pikachu_fan = player.pikachu_fan.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
        self.fisherman = player.fisherman.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
        self.berry_master = player.berry_master.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
        self.gym_leader = player.gym_leader.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
        self.champion = player.champion.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
        self.battle_legend = player.battle_legend.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
        self.total_unique_unown = player.total_unique_unown.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse

        self.total_perfect_pokemon = player.total_perfect_pokemon.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
        self.total_unique_perfect_pokemon = player.total_unique_perfect_pokemon.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
        self.total_gyms = player.total_gyms.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
        self.total_golds_gyms = player.total_golds_gyms.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
        self.total_golds_pokemon_per_type = player.total_golds_pokemon_per_type.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse

        self.last_updated = player.last_updated.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
      end
    end
  end
end
