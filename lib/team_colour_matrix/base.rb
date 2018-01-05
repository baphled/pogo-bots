module TeamColourMatrix
  class Base
    def self.colours
      abort('Must override')
    end
  end
end
