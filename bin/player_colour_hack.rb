require 'dotenv/load'
require 'mini_magick'
require 'yaml'

require 'pry'

require_relative '../lib/team_colour_matrix'
require_relative '../lib/team_colour_matrix/models/rgb_list'

image_url = 'https://cdn.discordapp.com/attachments/390221214624382977/398695926597812224/image.png'

image = MiniMagick::Image.open(image_url)
colour_array = image.get_pixels
puts colour_array.first.count
if colour_array.first.count >= 640
  top_left_corner = colour_array.first.first

  puts "[#{top_left_corner.join(',')}]"

  if TeamColourMatrix::Mystic.colours.include?(top_left_corner)
    team = 'Mystic'
  elsif TeamColourMatrix::Valor.colours.include?(top_left_corner)
    team = 'Valor'
  elsif TeamColourMatrix::Instinct.colours.include?(top_left_corner)
    team = 'Instinct'
  else
    team 'Unknown'
  end

  puts team
else
  puts 'Not a valid player screenshot'
end
