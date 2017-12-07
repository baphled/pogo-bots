module PogoStats
  module Renderer
    class InvalidComparison
      attr_accessor :selector_type
      attr_accessor :available_stats

      attr_accessor :message

      def initialize(selector_type:, available_stats:)
        self.available_stats = available_stats
        self.selector_type = selector_type
        self.message = ''
      end

      def render
        message = "Can not compare type: #{selector_type}\n"
        message << "Possible values to compare:\n"

        available_stats.each do |available_stat|
          message << "    - #{available_stat}\n"
        end

        message
      end
    end
  end
end
