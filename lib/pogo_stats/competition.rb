$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib', 'pogo_stats'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'active_record'

require 'models/player_statistic'

module PogoStats
  class Competition
    attr_accessor :players
    attr_accessor :state
    attr_accessor :statistic

    def initialize(players:, state:, statistic:)
      raise PogoStats::InvalidCompetitionState unless valid_states.include?(state.to_s.gsub(' ','_').to_sym)
      PogoStats::Stats::ComparisonSelector.find(statistic.to_s.gsub(' ','_').to_sym)

      self.players   = players
      self.state     = state
      self.statistic = statistic
    end

    def start
      entries = PogoStats::Models::PlayerStatistic.find_by(statistic: statistic.to_s)

      if entries.nil?
        players.entries.each do |entry|
          PogoStats::Models::PlayerStatistic.create!(
            discord_tag:     entry.discord_tag,
            player_tag:      entry.player_tag,
            statistic:       statistic.to_s,
            initial_value:   entry.public_send(statistic.to_sym)
          )
        end
        "Competition has now started!"
      else
        "Competition already started"
      end
    end

    def stop
      players.entries.each do |entry|
        player_entry = player_statistic.find_by(player_tag: entry.player_tag)

        if player_entry
          final_value = 0
          final_value += (entry.public_send(statistic.to_sym) - player_entry.initial_value.to_i)
          player_entry.update(final_value: final_value)
        end
      end

      winner = player_statistic.winner

      PogoStats::Models::PlayerStatistic.destroy(player_statistic.collect(&:id))

      message = """
      Congratulations #{winner.discord_tag}, you're the winner of the #{statistic} competition

      With a total of #{winner.final_value}

      Competition has now ended!
      """

      message
    end

    def cancel
      PogoStats::Models::PlayerStatistic.destroy(player_statistic.collect(&:id))

      "The #{statistic} competition has been cancelled"
    end

    def running
      "Currently have #{player_statistic.count} in the current competition"
    end

    protected

    def player_statistic
      PogoStats::Models::PlayerStatistic
        .where(statistic: statistic.to_s)
    end

    def valid_states
      [:start,:stop, :cancel, :running]
    end
  end
end
