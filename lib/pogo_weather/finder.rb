module PogoWeather
  class Finder
    def self.find(string)
      self.all.find { |weather| string.include?(weather[:conditions]) }
    end

    def self.all
      [
        {
          conditions: 'Clear',
          types: [
            'grass',
            'fire',
            'ground',
          ]
        },
        {
          conditions: 'Partly cloudy',
          types: [
            'normal',
            'rock',
          ]
        },
        {
          conditions: 'Rain',
          types: [
            'water',
            'electric',
            'bug',
          ]
        },
        {
          conditions: 'Snow',
          types: [
            'ice',
            'steel',
          ]
        },
        {
          conditions: 'Mostly cloudy',
          types: [
            'poison',
            'fighting',
            'fairy',
          ]
        },
        {
          conditions: 'fog',
          types: [
            'ghost',
            'dark',
          ]
        },
        {
          conditions: 'breezy',
          types: [
            'psychic',
            'flying',
            'dragon',
          ]
        },
      ]
    end
  end
end
