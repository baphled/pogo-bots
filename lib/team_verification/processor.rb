require 'mini_magick'

module TeamVerification
  class Processor
    attr_reader :uri
    attr_reader :pixel_width

    attr_reader :image
    attr_reader :colour_array
    attr_reader :image_processor

    def initialize(uri:, image_processor:)
      self.pixel_width = 640

      self.uri = uri
      self.image_processor = image_processor
      self.image = image_processor.open(uri)
      self.colour_array = image.get_pixels.first

      raise TeamVerification::InvalidPlayerImage if self.colour_array.count <= self.pixel_width
    end

    protected

    attr_writer :uri
    attr_writer :pixel_width

    attr_writer :image
    attr_writer :colour_array
    attr_writer :image_processor
  end
end
