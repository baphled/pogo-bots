module PogoStats
  module Stats
    class Player
      attr_accessor:mapper

      attr_accessor :name

      attr_accessor :team
      attr_accessor :discord_tag
      attr_accessor :player_tag

      attr_accessor :start_date

      attr_accessor :current_level
      attr_accessor :total_xp

      attr_accessor :pokemon_seen, :pokemon_caught

      def initialize(values)
        self.mapper         = PogoStats::Stats::Mapper

        self.name           = values[mapper.map[:name]]
        self.team           = values[mapper.map[:team]]

        self.discord_tag    = values[mapper.map[:discord_tag]]
        self.player_tag     = values[mapper.map[:player_tag]]

        #
        # Comparable attributes
        #
        self.start_date     = values[mapper.map[:start_date]]

        self.current_level  = values[mapper.map[:current_level]].to_i

        self.total_xp       = values[mapper.map[:total_xp]].delete(',').to_i

        self.pokemon_seen   = values[mapper.map[:pokemon_seen]].delete(',').to_i
        self.pokemon_caught = values[mapper.map[:pokemon_caught]].delete(',').to_i
      end

      #
      # TODO: Move this to a better home.
      #
      # As it is actually being passed a value object that so happens to
      # respond to similar messages than the data layer we should move it to a
      # transformations layer allow for value object to expose the correct
      # messages.
      #
      # These transformations will take a value object return the the ordered
      # list and pass it to the presentational layer for rendering.
      #
      def self.top_players(players:, compare: :total_xp, amount: 10)
        rows = players.sort do |entry_a, entry_b|
          entry_b.public_send(compare) <=> entry_a.public_send(compare)
        end

        rows[0...amount.to_i]
      end
    end
  end
end
