require 'dotenv/load'

require 'discordrb'
require 'active_support/inflector/inflections'

require_relative './data_sheet'
require_relative './display_presentation'

require_relative './lib/pogo_stats'

#TODO Use a different discord token
#TODO Enhance so that only certain roles can call specific commands

bot = Discordrb::Commands::CommandBot.new token: ENV['DISCORD_TOKEN'], prefix: '!'

bot.command(:competition, min_args: 2, description: 'Start a new competition') do |event, state, statistic|
  begin
    entries = PogoStats::Spreadsheet.new(values: response.values).entries
    players = PogoStats::ValueObject::Stats.new(entries)

    competition = PogoStats::Competition.new(players: players, state: state, statistic: statistic)

    message = competition.public_send(state.to_sym)

  rescue PogoStats::Stats::InvalidComparison
    message = 'Invalid comparison'
  rescue PogoStats::InvalidCompetitionState
    message = 'Invalid competition state'
  end

  event.respond message
end

bot.run
