require 'dotenv/load'

require 'yaml'
require 'discordrb'
require 'active_support'
require 'active_support/core_ext'

require 'mini_magick'

require "pry"

require_relative './lib/po_go_helper'
require_relative './lib/team_colour_matrix'

bot = Discordrb::Commands::CommandBot.new token: ENV['POGO_DISCORD_TOKEN'], prefix: '!'

bot.command(:links, description: 'Display helpful links') do |event|
  links = """
Pogo Stats: https://docs.google.com/spreadsheets/d/1ZLXHU0FU-_ejkxP_Z_19iEv5FBWDdJ_rQargbKh7qGY/edit?usp=sharing
  """

  event.respond links

  nil
end

bot.command(:'next-migration', description: 'Displays when the next migration will be') do |event|
  event.respond "The next nest migration is: #{PoGoHelper.next_migration}"

  nil
end

bot.command(:'current-migration', description: 'Displays when the current migration date') do |event|
  event.respond "The current migration ends on: #{PoGoHelper.current_migration}"

  nil
end

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
        event.respond "Type `!help` for more information"
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
