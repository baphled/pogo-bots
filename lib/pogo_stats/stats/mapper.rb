module PogoStats
  module Stats
    class Mapper
      def self.map
        {
          name: 0,
          player_tag: 1,
          team: 2,
          discord_tag: 3,
          start_date: 4,
          level_40_date: 5,
          current_level: 6,
          total_xp: 8,
          pokemon_seen: 9,
          pokemon_caught: 10,
        }
      end
    end
  end
end
