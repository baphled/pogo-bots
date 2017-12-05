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
        @entries << row
      end
    end
  end
end
