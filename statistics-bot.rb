require 'dotenv/load'
require 'pry'

require 'discordrb'

require_relative './data_sheet'
require_relative './display_presentation'

require_relative './lib/pogo_stats'

bot = Discordrb::Commands::CommandBot.new token: ENV['DISCORD_TOKEN'], prefix: '!'

bot.message(with_text: 'help!') do |event|
  message = """
!help               - Displays this message.
!links              - Useful links relating to the group.
!top amount (field) - Displays the top 10 in the league.
!user (username)   - Displays the statistics of a user.
!medals (username)  - Displays the medal a user has collected.
!compare (username)  - Compare yourself against another trainer
!top-team           - Display the top Pokemon Team
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

bot.command(:top, min_args: 1, max_args: 2, description: 'Display the top trainers based on a given stat') do |event, limiter, selector_type|
  if not limiter
    limiter = 10
  end

  if not selector_type
    selector_type = :total_xp
  end

  begin
    selector_hash = PogoStats::Stats::ComparisonSelector.find(selector_type.to_s.gsub(' ','_').to_sym)

    renderer = :not_yet_defined

    compare = selector_hash[:type]
    postfix = selector_hash[:postfix]

    entries = PogoStats::Spreadsheet.new(values: response.values).entries
    stats = PogoStats::ValueObject::Stats.new(entries)

    players = PogoStats::Stats::Player.top_players(amount: limiter, compare: compare, players: stats.entries)
    presenter = PogoStats::Presenter::Players.new(players)

    renderer = PogoStats::Renderer::TopPlayer.new(players: presenter.players, compare: compare, postfix: postfix)
  rescue NoMethodError, ArgumentError, PogoStats::Stats::InvalidComparison
    available_stats = PogoStats::Stats::ComparisonSelector.available_stats
    renderer = PogoStats::Renderer::InvalidComparison.new(selector_type: selector_type, available_stats: available_stats)
  ensure
    event.respond renderer.render
  end
  nil
end

bot.command(:user, min_args: 0, max_args: 1, description: 'Display a discord users PoGo statistics') do |event, player_name|
  player_name = event.user.name if not player_name

  entries = PogoStats::Spreadsheet.new(values: response.values).entries
  stats = PogoStats::ValueObject::Stats.new(entries)

  player = stats.entries.find { |stat| stat.discord_tag == player_name }

  if player.nil?
    event.respond "#{player_name} has not added their stats, type !links for the league URL"
  else
    presenter = PogoStats::Presenter::Player.new(player)
    event.respond print_player_stats(presenter)
  end
  nil
end

bot.command(:medals, min_args: 0, max_args: 1, description: 'Display a discord users PoGo statistics') do |event, player_name|
  player_name = event.user.name if not player_name

  entries = PogoStats::Spreadsheet.new(values: response.values).entries
  stats = PogoStats::ValueObject::Stats.new(entries)

  player = stats.entries.find { |stat| stat.discord_tag == player_name }

  if player.nil?
    event.respond "#{player_name} has not added their stats, type !links for the league URL"
  else
    presenter = PogoStats::Presenter::Player.new(player)
    event.respond print_player_medals(presenter)
  end
  nil
end

bot.message(start_with: '!compare') do |event|
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

bot.message(content: '!top-team') do |event|
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
