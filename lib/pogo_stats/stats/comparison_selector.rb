module PogoStats
  module Stats
    class ComparisonSelector
      def self.find(selector_type)
        [
          {
            type: :total_xp,
            postfix: 'XP'
          },
          {
            type: :collectors,
            postfix: 'Caught Pokemon'
          },
        ].find { |a| a[:type] == selector_type}
      end
    end
  end
end
