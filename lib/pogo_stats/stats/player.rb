module PogoStats
  module Stats
    class Player
      attr_accessor:mapper

      attr_accessor :name
      attr_accessor :discord_tag
      attr_accessor :player_tag

      attr_accessor :start_date

      attr_accessor :current_level
      attr_accessor :total_xp

      attr_accessor :pokemon_seen, :pokemon_caught

      def initialize(values)
        self.mapper = PogoStats::Stats::Mapper

        self.name = values[mapper.map[:name]]
        self.discord_tag = values[mapper.map[:discord_tag]]
        self.player_tag = values[mapper.map[:player_tag]]
        self.start_date = values[mapper.map[:start_date]]

        self.current_level = values[mapper.map[:current_level]]

        self.total_xp = values[mapper.map[:total_xp]]

        self.pokemon_seen = values[mapper.map[:pokemon_seen]]
        self.pokemon_caught = values[mapper.map[:pokemon_caught]]
      end
    end
  end
end
