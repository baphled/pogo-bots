module PogoStats
  module Stats
    class Player < PogoStats::Stats::Base
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
        super
        self.name           = sanitise_string(:name)
        self.team           = sanitise_string(:team)

        self.discord_tag    = sanitise_string(:discord_tag)
        self.player_tag     = sanitise_string(:player_tag)

        #
        # Comparable attributes
        #
        self.start_date     = sanitise_string(:start_date)

        self.current_level  = sanitise_number(:current_level)

        self.total_xp       = sanitise_number(:total_xp)

        self.pokemon_seen   = sanitise_number(:pokemon_seen)
        self.pokemon_caught = sanitise_number(:pokemon_caught)
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
