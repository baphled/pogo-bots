require 'dotenv/load'

require 'yaml'
require 'discordrb'
require 'active_support'
require 'active_support/core_ext'
require 'active_support/inflector/inflections'

require "pry"

require_relative './lib/po_go_helper'
require_relative './lib/team_colour_matrix'
require_relative './lib/pogo_weather'

bot = Discordrb::Commands::CommandBot.new token: ENV['POGO_DISCORD_TOKEN'], prefix: '!'

bot.command(:links, description: 'Display helpful links') do |event|
  links = """
**PoGo League spreadsheet**: https://docs.google.com/spreadsheets/d/1ZLXHU0FU-_ejkxP_Z_19iEv5FBWDdJ_rQargbKh7qGY/edit?usp=sharing
**Gamepress PoGo**: https://pokemongo.gamepress.gg
  """

  event.respond links

  nil
end

bot.command(:'next-migration', description: 'Displays when the next migration will be') do |event|
  event.respond "The next nest migration is: #{PoGoHelper.next_migration}"

  nil
end

bot.command(:weather, description: 'Provides a weather forecast for a city') do |event, *city|
  city = city.join(' ')
  city = 'Bath' if city.nil? or city.empty?

  locations = Accuweather.city_search(name: city)
  if locations.empty?
    event.respond "#{city} not found"
  else
    #TODO Do not assume the first location is the correct one
    location = locations.first

    current_weather = Accuweather.get_conditions(location_id: location.id).current

    event.respond "#{current_weather.weather_text} in #{city.capitalize}, #{location.state} "
    event.respond "Expect to encounter more #{PogoWeather::Finder.find(current_weather.weather_text)[:types].join(', ')} type pokemon."
  end

  nil
end

bot.message(in: "#introduction") do |event|
  if not event.message.attachments.empty?
    begin
      image_url = event.message.attachments.first.url
      rgb_value = TeamVerification.start(uri: image_url)

      team = TeamColourMatrix.verified_team(rgb_value)

      TeamVerification.complete(event: event, team: team)
    rescue TeamVerification::InvalidPlayerImage
      event.respond "**Invalid player screenshot**"
    rescue TeamVerification::DiscordRoleNotFound
      event.respond "Unable to set #{event.user.name} role (#{team})"
    rescue TeamColourMatrix::TeamNotFound
      TeamVerification.contact_mods(event: event, rgb: rgb_value, uri: image_url)
    end
  end
end

# TODO mods = 341186632843788291
#
# Need to change this so that it is not tied to a specific discord guild
#
bot.command(:'set-colour', required_roles: [341186632843788291], min_args: 2, max_args: 2, description: 'Allows a user to define a RGB for a PoGo team') do |event, rgb_args, team|
  teams = [
    'Mystic',
    'Valor',
    'Instinct',
  ]

  if teams.include?(team.capitalize)
    r,g,b = rgb_args[1..-2].split(',').collect! {|n| n.to_i}
    rgb_list = TeamColourMatrix::Models::RgbList.new(r: r, g: g, b: b, team: team.capitalize)
    if rgb_list.save
      event.respond 'New RGB added'
    else
      rgb_list.errors.full_messages.each do |message|
        event.respond message
      end
    end
  else
    event.respond 'Invalid command'
  end
  nil
end

bot.command(:'verified-rgbs', required_roles: [341186632843788291], min_args: 1, max_args: 1, description: 'Return a list of RGB values for a given team') do |event, team|
  team = team.capitalize
  teams = [
    'Mystic',
    'Valor',
    'Instinct',
  ]

  if teams.include?(team)
    colours = TeamColourMatrix::Models::RgbList.where(team: team)
    colours = colours.sort { |a,b| [a.r,a.g,a.b] <=> [b.r,b.g,b.b] }

    if colours.empty?
      event.respond 'No RGB values found'
    else
			message = ERB.new(<<-BLOCK).result(binding)
<% colours.each do |colour| %>
[<%= colour.r %>,<%= colour.g %>,<%= colour.b %>]
<% end %>
BLOCK

      event.respond message
    end
  else
    event.respond 'Invalid command'
  end
end

bot.run
