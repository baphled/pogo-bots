module PogoStats
  class Spreadsheet
    attr_accessor :entries
    attr_accessor :original_values

    def initialize(values:)
      self.original_values = values

      self.entries = values
    end

    def entries=(values)
      @entries ||= []

      values.each do |row|
        break if row[0].nil?

        player = PogoStats::Stats::Player.new(row)
        medals = PogoStats::Stats::Medals.new(row)
        overall = PogoStats::Stats::Overall.new(row)

        entry = PogoStats::Stats::Entry.new(player: player, medals: medals, overall: overall)

        @entries << entry
      end
    end
  end
end
