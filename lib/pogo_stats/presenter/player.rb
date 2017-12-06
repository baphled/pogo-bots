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
      attr_reader :pokemon_seen, :pokemon_caught

      protected

      attr_writer :name
      attr_writer :team
      attr_writer :discord_tag
      attr_writer :player_tag
      attr_writer :start_date
      attr_writer :current_level
      attr_writer :total_xp
      attr_writer :pokemon_seen, :pokemon_caught

      def initialize(player)
        self.name = player.name
        self.discord_tag = player.discord_tag

        self.player_tag = player.player_tag
        self.team = player.team

        self.start_date = player.start_date
        self.current_level = player.current_level
        self.total_xp = player.total_xp.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse

        self.pokemon_seen = player.pokemon_seen.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
        self.pokemon_caught = player.pokemon_caught.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
      end
    end
  end
end
