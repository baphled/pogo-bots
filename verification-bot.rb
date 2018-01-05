require 'dotenv/load'
require 'mini_magick'

require 'discordrb'

require 'pry'

mystic_colours = [
  [0,42,84],
  [0, 71, 142],
  [0, 71, 143],
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
  [91, 73, 0],
]

bot = Discordrb::Bot.new token: ENV['VERIFICATION_DISCORD_BOT']

bot.message(in: "#introduction") do |event|
  team = :undefined

  if not event.message.attachments.empty?
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
    end

    if team != :undefined
      found_role = event.server.roles.find { |role| role.name == team }

      role_id = found_role.id

      if !role_id.nil?
        event.user.add_role(role_id)

        event.respond "Verified: #{event.user.name} as a member of team #{team}"
      else
        event.respond 'Unable to verify player'
      end
    else
      admin_user = event.server.users.find { |u| u.name == ENV['DEVELOPER_DISCORD_NAME']}

      admin_user.pm("Member: #{event.user.name}")
      admin_user.pm("RBG: #{top_left_corner}")
      admin_user.pm("Player Image: #{image_url}")
    end
  end
end

bot.run
