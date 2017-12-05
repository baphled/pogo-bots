module PogoStats
  module Stats
    class Entry
      attr_accessor :player, :medals, :overall

      def initialize(player:, medals:, overall:)
        self.player = player
        self.medals = medals
        self.overall = overall
      end
    end
  end
end
