module PogoStats
  module Stats
    class Medals
      attr_accessor :collectors

      attr_accessor :mapper

      def initialize(values)
        self.mapper    = PogoStats::Stats::Mapper

        self.collectors = values[mapper.map[:collectors]].delete(',').to_i
      end
    end
  end
end
