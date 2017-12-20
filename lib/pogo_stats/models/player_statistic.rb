module PogoStats
  module Models
    class PlayerStatistic < ActiveRecord::Base
      def self.winner
        order(:final_value)
          .last
      end
    end
  end
end
