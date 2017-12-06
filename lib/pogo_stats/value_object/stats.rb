module PogoStats
  module ValueObject
    class Stats
      attr_accessor :entries
      def initialize(entries)
        self.entries = entries
      end

      def entries=(entries)
        @entries ||= entries.collect do |entry|
          PogoStats::ValueObject::PlayerStatistics.new(entry)
        end
      end
    end
  end
end
