module PogoWeather
  class Finder
    def self.find(string)
      self.all.find do |weather|
        weather[:conditions].find do |condition|
          string.downcase.include?(condition)
        end
      end
    end

    def self.all
      [
        {
          conditions: [
            'mostly sunny',
            'partly cloudy',
          ],
          types: [
            'normal',
            'rock',
          ]
        },
        {
          conditions: [
            'clear',
            'sunny',
          ],
          types: [
            'grass',
            'fire',
            'ground',
          ]
        },
        {
          conditions: [
            'rain',
            'shower'
          ],
          types: [
            'water',
            'electric',
            'bug',
          ]
        },
        {
          conditions: [
            'snow'
          ],
          types: [
            'ice',
            'steel',
          ]
        },
        {
          conditions: [
            'overcast'
          ],
          types: [
            'poison',
            'fighting',
            'fairy',
          ]
        },
        {
          conditions: [
            'fog'
          ],
          types: [
            'ghost',
            'dark',
          ]
        },
        {
          conditions: [
            'breezy'
          ],
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
