module PogoStats
  module Renderer
    class TopPlayer
      attr_accessor :players
      attr_accessor :compare
      attr_accessor :postfix

      attr_accessor :message

      def initialize(players:, compare: :total_xp, postfix: 'XP')
        self.players = players
        self.compare = compare
        self.postfix = postfix

        self.message = ''
      end

      def render
        players.each_with_index do |player, index|
          message << "#{(index + 1)} #{player.player_tag} (#{player.team}) - #{player.public_send(compare.to_sym)} #{postfix}\n"
        end

        message
      end
    end
  end
end
