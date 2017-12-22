require 'dotenv/load'

require 'discordrb'
require 'accuweather'

require 'active_support/inflector/inflections'
require "pry"

bot = Discordrb::Commands::CommandBot.new token: ENV['ACCUWEATHER_DISCORD_TOKEN'], prefix: '!'

bot.command(:weather, description: 'Provides a weather forecast for a city') do |event, *city|
  city = city.join(' ')
  city = 'Bath' if city.nil? or city.empty?

  locations = Accuweather.city_search(name: city)
  if locations.empty?
    event.respond "#{city} not found"
  else
    location = locations.first

    current_weather = Accuweather.get_conditions(location_id: location.id).forecast

    if Time.now < Time.parse(current_weather.first.sunset)
      current_weather = current_weather.first.daytime
    else
      current_weather = current_weather.first.nighttime
    end
    event.respond "#{current_weather.weather_text} in #{city.capitalize}, #{location.state}" 
  end

  nil
end

bot.run
