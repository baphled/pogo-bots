module PogoStats
  module Stats
    class InvalidComparison < Exception; end
    class InvalidArguments < Exception; end

    class ComparisonSelector
      def self.comparable_array
        [
          {
            type: :total_xp,
            postfix: 'XP'
          },
          {
            type: :collectors,
            postfix: 'Caught Pokemon'
          },
          {
            type: :jogger,
            postfix: 'Distance walked'
          },
          {
            type: :scientist,
            postfix: 'Pokemon Evolved'
          },
          {
            type: :breeder,
            postfix: 'Pokemon Hatched'
          },
          {
            type: :backpacker,
            postfix: 'Pokestops Visited'
          },
          {
            type: :battle_girl,
            postfix: 'Gym Battles'
          },
          {
            type: :youngster,
            postfix: 'Tiny Rattata Caught'
          },
          {
            type: :pikachu_fan,
            postfix: 'Pikachu Caught'
          },
          {
            type: :fisherman,
            postfix: 'Big Magikarp Caught'
          },
          {
            type: :berry_master,
            postfix: 'Pokemon Berried'
          },
          {
            type: :gym_leader,
            postfix: 'Hours Defending Gyms'
          },
          {
            type: :champion,
            postfix: 'Raids Won'
          },
          {
            type: :ace_trainer,
            postfix: 'Gyms Trained'
          },
          {
            type: :battle_legend,
            postfix: 'Legenday Raids Won'
          },
          {
            type: :total_unique_unown,
            postfix: 'Unique Unowns Caught'
          },
          {
            type: :total_golds_pokemon_per_type,
            postfix: 'Total Completed Pokemon Types'
          },
          {
            type: :total_perfect_pokemon,
            postfix: 'Total Perfect Pokemon'
          },
          {
            type: :total_unique_perfect_pokemon,
            postfix: 'Total Unique Perfect Pokemon'
          },
          {
            type: :total_gyms,
            postfix: 'Total Gyms Visited'
          },
          {
            type: :total_golds_gyms,
            postfix: 'Total Gold Gyms Held'
          },
        ]
      end

      def self.find(selector_type)
        found = comparable_array.find { |a| a[:type] == selector_type}

        if found
          found
        else
          raise(PogoStats::Stats::InvalidComparison)
        end
      end

      def self.available_stats
        comparable_array.collect { |key|  key[:type] }
      end
    end
  end
end
