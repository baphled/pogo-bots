module PogoStats
  class Spreadsheet
    attr_accessor :entries
    attr_accessor :original_values

    def initialize(values:)
      self.original_values = values
    end
  end
end
