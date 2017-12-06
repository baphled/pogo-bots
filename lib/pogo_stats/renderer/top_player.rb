module PogoStats
  module Renderer
    class TopPlayer
      attr_accessor :players

      attr_accessor :message

      def initialize(players)
        self.players = players

        self.message = ''
      end

      def render
        players.each_with_index do |player, index|
          message << "#{(index + 1)} #{player.player_tag} (#{player.team}) - #{player.total_xp} XP\n"
        end

        message
      end
    end
  end
end
