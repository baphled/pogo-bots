require 'dotenv/load'
require 'mini_magick'

require 'pry'

require_relative './lib/team_colour_matrix'

image_url = 'https://cdn.discordapp.com/attachments/390221214624382977/398695926597812224/image.png'

image = MiniMagick::Image.open(image_url)
colour_array = image.get_pixels
top_left_corner = colour_array.first.first

puts top_left_corner

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
