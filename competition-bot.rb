require 'dotenv/load'

require 'discordrb'
require 'active_support/inflector/inflections'

require_relative './data_sheet'
require_relative './display_presentation'

require_relative './lib/pogo_stats'

#TODO Use a different discord token
#TODO Enhance so that only certain roles can call specific commands

bot = Discordrb::Commands::CommandBot.new token: ENV['COMPETITION_DISCORD_TOKEN'], prefix: '!'

bot.command(:competition, min_args: 2, description: 'Start a new competition') do |event, state, statistic|
  begin
    entries = PogoStats::Spreadsheet.new(values: response.values).entries
    players = PogoStats::ValueObject::Stats.new(entries)

    competition = PogoStats::Competition.new(players: players, state: state, statistic: statistic)

    message = competition.public_send(state.to_sym)

  rescue PogoStats::Stats::InvalidComparison
    available_stats = PogoStats::Stats::ComparisonSelector.available_stats
    renderer = PogoStats::Renderer::InvalidComparison.new(selector_type: statistic, available_stats: available_stats)

    message = renderer.render
  rescue PogoStats::InvalidCompetitionState
    message = 'Invalid competition state. Use start, stop, cancel or running'
  end

  event.respond message
end

bot.run
