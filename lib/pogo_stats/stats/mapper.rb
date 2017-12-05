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

          collectors: 12,
          jogger: 13,
          scientist: 14,
          breeder: 15,
          backpacker: 16,
          battle_girl: 17,
          ace_trainer: 18,
          youngster: 19,
          pikachu_fan: 20,
          fisherman: 21,
          berry_master: 22,
          gym_leader: 23,
          champion: 24,
          battle_legend: 25,
          total_unique_unown: 26,

          total_perfect_pokemon: 27,
          total_unique_perfect_pokemon: 28,
          total_gyms: 29,
          total_golds_gyms: 30,
          total_golds_pokemon_per_type: 31,
          last_updated: 32
        }.freeze
      end
    end
  end
end
