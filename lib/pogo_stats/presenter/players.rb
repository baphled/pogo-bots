module PogoStats
  module Presenter
    class Players
      attr_accessor :players

      def initialize(array_of_players)
        self.players = array_of_players.collect do |player|
          PogoStats::Presenter::Player.new(player)
        end
      end
    end
  end
end
