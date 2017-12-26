module PogoWeather
  class Finder
    def self.find(string)
      self.all.find { |weather| string.downcase.include?(weather[:conditions]) }
    end

    def self.all
      [
        {
          conditions: 'clear',
          types: [
            'grass',
            'fire',
            'ground',
          ]
        },
        {
          conditions: 'partly cloudy',
          types: [
            'normal',
            'rock',
          ]
        },
        {
          conditions: 'rain',
          types: [
            'water',
            'electric',
            'bug',
          ]
        },
        {
          conditions: 'snow',
          types: [
            'ice',
            'steel',
          ]
        },
        {
          conditions: 'mostly cloudy',
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
