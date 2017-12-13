module PogoStats
  module Stats
    class Overall < PogoStats::Stats::Base
      attr_accessor :total_perfect_pokemon
      attr_accessor :total_unique_perfect_pokemon
      attr_accessor :total_gyms
      attr_accessor :total_golds_gyms
      attr_accessor :total_golds_pokemon_per_type
      attr_accessor :last_updated

      attr_accessor :mapper

      def initialize(values)
        super

        self.total_perfect_pokemon        = sanitise_number(:total_perfect_pokemon)
        self.total_unique_perfect_pokemon = sanitise_number(:total_unique_perfect_pokemon)
        self.total_gyms                   = sanitise_number(:total_gyms)
        self.total_golds_gyms             = sanitise_number(:total_golds_gyms)
        self.total_golds_pokemon_per_type = sanitise_number(:total_golds_pokemon_per_type)

        self.last_updated                 = sanitise_string(:last_updated)
      end
    end
  end
end
