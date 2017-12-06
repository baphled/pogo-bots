require 'dotenv/load'
require 'pry'

require 'discordrb'

require_relative './data_sheet'
require_relative './display_presentation'

require_relative './lib/pogo_stats'

bot = Discordrb::Bot.new token: ENV['DISCORD_TOKEN']

bot.message(with_text: 'help!') do |event|
  message = """
help!               - Displays this message.
links!              - Useful links relating to the group.
top10!              - Displays the top 10 in the league.
stats! (username)   - Displays the statistics of a user.
medals! (username)  - Displays the medal a user has collected.
compare! (username)  - Compare yourself against another trainer
top-team!           - Display the top Pokemon Team
  """

  event.respond message
end

bot.message(with_text: 'boo!') do |event|
  event.respond ':mystic:'
end

bot.message(with_text: 'links!') do |event|
  links = """
Pogo Stats: https://docs.google.com/spreadsheets/d/1ZLXHU0FU-_ejkxP_Z_19iEv5FBWDdJ_rQargbKh7qGY/edit?usp=sharing
  """

  event.respond links
end

bot.message(with_text: 'top10!') do |event|
  entries = PogoStats::Spreadsheet.new(values: response.values).entries

  players = PogoStats::Stats::Player.top_players(amount: 10, players: entries.collect(&:player))

  presenter = PogoStats::Presenter::Players.new(players)
  renderer = PogoStats::Renderer::TopPlayer.new(presenter.players)

  event.respond renderer.render
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

bot.message(content: 'stats!') do |event|
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

bot.message(content: 'medals!') do |event|

  row = response.values.select { |stats| stats[3] == event.user.name }.flatten

  if row.empty?
    event.respond 'You have not added your stats, type !links for the league URL'
  else
    stats = player_info(row).merge(player_medals(row)).merge(player_overall_stats(row))

    event.respond print_player_medals(stats)
  end
end


bot.message(start_with: 'compare!') do |event|
  expected_name = event.message.content.split.last

  row = response.values.select { |stats| stats[3] == expected_name }.flatten

  my_row = response.values.select { |stats| stats[3] == event.user.name }.flatten

  message = ""

  if row.empty?
    event.respond "#{expected_name} have not added their stats, type !links for the league URL"
  else
    my_stats = player_info(my_row).merge(player_medals(my_row)).merge(player_overall_stats(my_row))
    their_stats = player_info(row).merge(player_medals(row)).merge(player_overall_stats(row))

    leader, runner_up = [my_stats, their_stats].sort { |a,b| b[:total_xp] <=> a[:total_xp] }
    message << print_compare_players(leader, runner_up, :total_xp, 'XP')

    leader, runner_up = [my_stats, their_stats].sort { |a,b| b[:total_gyms] <=> a[:total_gyms] }
    message << print_compare_players(leader, runner_up, :total_gyms, 'Total Gyms')

    leader, runner_up = [my_stats, their_stats].sort { |a,b| b[:total_golds_gyms] <=> a[:total_golds_gyms] }
    message << print_compare_players(leader, runner_up, :total_golds_gyms, 'Total Gold Gyms')

    leader, runner_up = [my_stats, their_stats].sort { |a,b| b[:total_perfect_pokemon] <=> a[:total_perfect_pokemon] }
    message << print_compare_players(leader, runner_up, :total_perfect_pokemon, 'Total 100% Pokemon')

    leader, runner_up = [my_stats, their_stats].sort { |a,b| b[:total_unique_perfect_pokemon] <=> a[:total_unique_perfect_pokemon] }
    message << print_compare_players(leader, runner_up, :total_unique_perfect_pokemon, 'Total Unique 100% Pokemon')

    event.respond message
  end
end

bot.message(content: 'top-team!') do |event|
  hashes = []
  response.values.each do |row|
    break if row[0].nil?
    hash =  player_info(row)
    hashes << {team: hash[:team], total_xp: hash[:total_xp]}
  end

  message = ''
  ordered = []
  teams = hashes.collect { |hash| hash[:team].strip }.uniq

  teams.each do |team|
    team_members = hashes.collect do |hash|
      if hash[:team].strip.downcase == team.strip.downcase
        hash
      end
    end.compact

    team_total_xp = team_members.collect { |member| member[:total_xp] }
    team_hash = {
      team: team.downcase.to_sym,
      total_xp: team_total_xp.reduce(0) { |a,b| a + b },
      players_count: team_members.count
    }
    ordered << team_hash
  end

  ordered.each_with_index do |team, index|
    message << print_top_team(team, index)
  end

  event.respond message
end

bot.run
