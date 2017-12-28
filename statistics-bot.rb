require 'dotenv/load'

require 'discordrb'

require_relative './data_sheet'
require_relative './display_presentation'

require_relative './lib/pogo_stats'

bot = Discordrb::Commands::CommandBot.new token: ENV['STATS_DISCORD_TOKEN'], prefix: '!'

bot.command(:top, min_args: 1, max_args: 2, description: 'Display the top trainers based on a given stat') do |event, limiter, selector_type|
  limiter = limiter.to_i

  limiter = 10 if (not limiter)
  selector_type = :total_xp if not selector_type
  renderer = :not_yet_defined

  begin
    raise PogoStats::Stats::InvalidArguments if limiter == 0
    selector_hash = PogoStats::Stats::ComparisonSelector.find(selector_type.to_s.gsub(' ','_').to_sym)


    compare = selector_hash[:type]
    postfix = selector_hash[:postfix]

    entries = PogoStats::Spreadsheet.new(values: response.values).entries
    stats = PogoStats::ValueObject::Stats.new(entries)

    players = PogoStats::Stats::Player.top_players(amount: limiter, compare: compare, players: stats.entries)
    presenter = PogoStats::Presenter::Players.new(players)

    renderer = PogoStats::Renderer::TopPlayer.new(players: presenter.players, compare: compare, postfix: postfix)
  rescue NoMethodError, PogoStats::Stats::InvalidComparison
    available_stats = PogoStats::Stats::ComparisonSelector.available_stats
    renderer = PogoStats::Renderer::InvalidComparison.new(selector_type: selector_type, available_stats: available_stats)
  rescue PogoStats::Stats::InvalidArguments
    available_stats = PogoStats::Stats::ComparisonSelector.available_stats
    renderer = PogoStats::Renderer::InvalidArguments.new(selector_type: selector_type, available_stats: available_stats)
  end
  event.respond renderer.render

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

bot.command(:compare, min_args: 1, max_args: 1, description: 'Compare your stats with another user') do |event, other_player|
  expected_name = other_player

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

bot.command(:'top-team', min_args: 0, max_args: 1, description: 'Display who the top Pokemon Go team is') do |event, selector_type|
  entries = PogoStats::Spreadsheet.new(values: response.values).entries
  stats = PogoStats::ValueObject::Stats.new(entries)

  selector_type = 'total_xp' unless selector_type

  begin
    selector_hash = PogoStats::Stats::ComparisonSelector.find(selector_type.to_s.gsub(' ','_').to_sym)


    compare = selector_hash[:type]
    postfix = selector_hash[:postfix]

    message = "Top Team by #{postfix}:\n\n"

    ordered = []
    teams = stats.entries.collect { |hash| hash.team.strip }.uniq

    teams.each do |team|
      team_members = stats.entries.collect do |hash|
        if hash.team.strip.downcase == team.strip.downcase
          hash
        end
      end.compact

      team_total = team_members.collect { |member| member.public_send(compare.to_sym) }
      team_hash = {
        team: team.downcase.to_sym,
        selector_type.to_sym => team_total.reduce(0) { |a,b| a + b },
        players_count: team_members.count
      }
      ordered << team_hash
    end

    ordered.each_with_index do |team, index|
      message << print_top_team(team, index, compare, postfix)
    end

  rescue NoMethodError, PogoStats::Stats::InvalidComparison
    available_stats = PogoStats::Stats::ComparisonSelector.available_stats
    renderer = PogoStats::Renderer::InvalidComparison.new(selector_type: selector_type, available_stats: available_stats)
    message = renderer.render
  end

  event.respond message

  nil
end

bot.command(:league, description: 'Displays general information about the existing league') do |event|
  entries = PogoStats::Spreadsheet.new(values: response.values).entries
  stats = PogoStats::ValueObject::Stats.new(entries)

  event.respond "There are currently #{stats.entries.count} Discord users entered into the league"
end

bot.run
