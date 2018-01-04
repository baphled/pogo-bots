require 'dotenv/load'
require 'mini_magick'

require 'discordrb'

require 'pry'

mystic_colours = [
  [0,42,84],
  [0, 71, 142],
  [1,120,238],
  [2,116,241],
]

valor_colours = [
  [234, 53, 60],
  [89, 0, 17],
  [90, 0, 18],
  [255, 9, 49],
]

instinct_colours = [
  [255, 200, 5],
  [246, 202, 69],
  [153, 122, 0],
]

team = :undefined

bot = Discordrb::Bot.new token: ENV['VERIFICATION_DISCORD_BOT']

bot.message(in: "#bot-fun") do |event|
  image_url = event.message.attachments.first.url

  image = MiniMagick::Image.open(image_url)
  colour_array = image.get_pixels
  top_left_corner = colour_array.first.first

  if mystic_colours.include?(top_left_corner)
    team = 'Mystic'
  elsif valor_colours.include?(top_left_corner)
    team = 'Valor'
  elsif instinct_colours.include?(top_left_corner)
    team = 'Instinct'
  else
    team = 'Unknown'
  end
  event.respond "Verified: #{team} member"
end

bot.run
