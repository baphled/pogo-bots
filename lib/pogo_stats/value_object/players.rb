module PogoStats
  module ValueObject
    class Players
      attr_accessor :all

      def initialize(entries)
        self.entries = entries
      end

      def all=(entries)
        @all ||= entries.collect do |entry|
          PogoStats::ValueObject::PlayerStatistics.new(entry)
        end
      end
    end
  end
end
