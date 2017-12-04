require 'dotenv/load'
require 'pry'

require 'discordrb'

require_relative './data_sheet.rb'
require_relative './display_presentation.rb'

bot = Discordrb::Bot.new token: ENV['DISCORD_TOKEN']

bot.message(with_text: 'help!') do |event|
  message = """
help!               - Displays this message.
link!               - Useful links relating to the group.
stats! (username)   - Displays the statistics of a user.
medals! (username)  - Displays the medal a user has collected.
  """

  event.respond message
end

bot.message(with_text: 'links!') do |event|
  links = """
Pogo Stats: https://docs.google.com/spreadsheets/d/1ZLXHU0FU-_ejkxP_Z_19iEv5FBWDdJ_rQargbKh7qGY/edit?usp=sharing
  """

  event.respond links
end

bot.message(with_text: 'top-10!') do |event|

  hashes = []
  response.values.each do |row|
    break if row[0].nil?
    hashes << player_info(row)
  end

  rows = hashes.sort { |a,b| b[:total_xp] <=> a[:total_xp] }[0...10]

  message = ""

  rows.each_with_index do |stats, index|

    message << "#{index + 1}. #{stats[:player_tag]} (#{stats[:team]}) - #{stats[:total_xp]}\n"
  end

  event.respond message
end

bot.message(starting_with: 'stats!') do |event|
  # Hack to stop us from triggering the wrong stats message
  if event.message.content.split.count > 1
    expected_name = event.message.content.split.last

    row = response.values.select { |stats| stats[3] == expected_name }.flatten

    if row.empty?
      event.respond "#{expected_name} has not added their stats, type !links for the league URL"
    else
      stats = player_info(row).merge(player_medals(row)).merge(player_overall_stats(row))

      event.respond print_player_stats(stats)
    end
  end
end

bot.message(with_text: 'stats!') do |event|
  row = response.values.select { |stats| stats[3] == event.user.name }.flatten

  if row.empty?
    event.respond 'You have not added your stats, type !links for the league URL'
  else
    stats = player_info(row).merge(player_medals(row)).merge(player_overall_stats(row))

    event.respond print_player_stats(stats)
  end
end

bot.message(starting_with: 'medals!') do |event|

  if event.message.content.split.count > 1
    expected_name = event.message.content.split.last

    row = response.values.select { |stats| stats[3] == expected_name }.flatten

    if row.empty?
      event.respond 'You have not added your stats, type !links for the league URL'
    else
      stats = player_info(row).merge(player_medals(row)).merge(player_overall_stats(row))

      event.respond print_player_medals(stats)
    end
  end
end

bot.message(with_text: 'medals!') do |event|

  row = response.values.select { |stats| stats[3] == event.user.name }.flatten

  if row.empty?
    event.respond 'You have not added your stats, type !links for the league URL'
  else
    stats = player_info(row).merge(player_medals(row)).merge(player_overall_stats(row))

    event.respond print_player_medals(stats)
  end
end

bot.run
