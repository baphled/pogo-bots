module TeamColourMatrix
  class Base
    def self.team
      abort('Must override')
    end

    def self.colours
      models = TeamColourMatrix::Models::RgbList.where(team: self.team)
      models.collect { |model| [model.r.to_i,model.g.to_i,model.b.to_i] }
    end
  end
end
