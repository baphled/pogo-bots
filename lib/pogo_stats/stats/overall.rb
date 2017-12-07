module PogoStats
  module Stats
    class Overall
      attr_accessor :total_perfect_pokemon
      attr_accessor :total_unique_perfect_pokemon
      attr_accessor :total_gyms
      attr_accessor :total_golds_gyms
      attr_accessor :total_golds_pokemon_per_type
      attr_accessor :last_updated

      attr_accessor :mapper

      def initialize(values)
        self.mapper    = PogoStats::Stats::Mapper

        self.total_perfect_pokemon = values[mapper.map[:total_perfect_pokemon]].to_i
        self.total_unique_perfect_pokemon = values[mapper.map[:total_unique_perfect_pokemon]].to_i
        self.total_gyms = values[mapper.map[:total_gyms]].to_i
        self.total_golds_gyms = values[mapper.map[:total_golds_gyms]].to_i
        self.total_golds_pokemon_per_type = values[mapper.map[:total_golds_pokemon_per_type]].to_i

        self.last_updated = values[mapper.map[:last_updated]]
      end
    end
  end
end
