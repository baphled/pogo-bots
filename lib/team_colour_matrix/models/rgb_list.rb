module TeamColourMatrix
  module Models
    class RgbList < ActiveRecord::Base
      validates_uniqueness_of :team, scope: [:r, :g, :b]

      validates_presence_of :r
      validates_presence_of :g
      validates_presence_of :b

      validates_presence_of :team

      validates_inclusion_of :team, in: ['Valor', 'Mystic', 'Instinct']
    end
  end
end
