module PogoStats
  module Stats
    class Base
      attr_accessor :values
      attr_accessor :mapper

      protected :mapper
      protected :values

      def initialize(values)
        self.mapper    = PogoStats::Stats::Mapper

        self.values = values
      end

      def sanitise_number(field)
        values[mapper.map[field]].nil? ? 0 : values[mapper.map[field]].delete(',').to_i
      end

      def sanitise_string(field)
        values[mapper.map[field]].nil? ? '' : values[mapper.map[field]].to_s
      end
    end
  end
end
