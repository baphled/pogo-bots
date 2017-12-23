require 'dotenv/load'

require 'discordrb'
require 'accuweather'

require 'active_support/inflector/inflections'
require "pry"

require_relative './lib/pogo_weather'

bot = Discordrb::Commands::CommandBot.new token: ENV['ACCUWEATHER_DISCORD_TOKEN'], prefix: '!'

bot.command(:weather, description: 'Provides a weather forecast for a city') do |event, *city|
  city = city.join(' ')
  city = 'Bath' if city.nil? or city.empty?

  locations = Accuweather.city_search(name: city)
  if locations.empty?
    event.respond "#{city} not found"
  else
    #TODO Do not assume the first location is the correct one
    location = locations.first

    current_weather = Accuweather.get_conditions(location_id: location.id).forecast

    time_of_day = :not_defined
    time_of_day = (Time.now < Time.parse(current_weather.first.sunset)) ? :daytime : :nighttime

    current_weather = current_weather.first.public_send(time_of_day)

    event.respond "#{current_weather.weather_text} in #{city.capitalize}, #{location.state} "
    event.respond "Expect to encounter more #{PogoWeather::Finder.find(current_weather.weather_text)[:types].join(', ')} type pokemon."
  end

  nil
end

bot.run
