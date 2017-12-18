module PogoStats
  module Renderer
    class InvalidArguments
      attr_accessor :selector_type
      attr_accessor :available_stats

      attr_accessor :message

      def initialize(selector_type:, available_stats:)
        self.message = ''
      end

      def render
        message << "Invalid request, try !top <number> <selector>"
        message
      end
    end
  end
end
