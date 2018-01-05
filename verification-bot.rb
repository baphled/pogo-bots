require 'dotenv/load'
require 'mini_magick'

require 'discordrb'

require 'pry'

require_relative './lib/team_colour_matrix'

bot = Discordrb::Bot.new token: ENV['VERIFICATION_DISCORD_BOT']

bot.message(in: "#introduction") do |event|
  team = :undefined

  if not event.message.attachments.empty?
    image_url = event.message.attachments.first.url
    image = MiniMagick::Image.open(image_url)
    colour_array = image.get_pixels
    top_left_corner = colour_array.first.first

    if TeamColourMatrix::Mystic.colours.include?(top_left_corner)
      team = 'Mystic'
    elsif TeamColourMatrix::Valor.colours.include?(top_left_corner)
      team = 'Valor'
    elsif TeamColourMatrix::Instinct.colours.include?(top_left_corner)
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
