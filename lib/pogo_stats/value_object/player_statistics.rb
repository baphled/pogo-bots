module PogoStats
  module ValueObject
    class PlayerStatistics
      attr_accessor :name
      attr_accessor :discord_tag
      attr_accessor :player_tag
      attr_accessor :team

      # Comparable attributes

      attr_accessor :start_date
      attr_accessor :current_level
      attr_accessor :total_xp
      attr_accessor :pokemon_seen
      attr_accessor:pokemon_caught


      def initialize(entry)
        self.name = entry.player.name
        self.discord_tag = entry.player.discord_tag

        self.player_tag = entry.player.player_tag
        self.team = entry.player.team

        self.start_date = entry.player.start_date

        self.current_level = entry.player.current_level
        self.total_xp = entry.player.total_xp

        self.pokemon_seen = entry.player.pokemon_seen
        self.pokemon_caught = entry.player.pokemon_caught
      end
    end
  end
end
