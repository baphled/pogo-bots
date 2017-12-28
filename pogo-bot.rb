require 'dotenv/load'

require 'yaml'
require 'discordrb'
require 'active_support'
require 'active_support/core_ext'

require "pry"

require_relative './lib/po_go_helper'

bot = Discordrb::Commands::CommandBot.new token: ENV['POGO_DISCORD_TOKEN'], prefix: '!'

bot.command(:'next-migration', description: 'Displays when the next migration will be') do |event|
  event.respond "The next nest migration is: #{PoGoHelper.next_migration}"

  nil
end

bot.command(:'current-migration', description: 'Displays when the current migration date') do |event|
  event.respond "The next nest migration is: #{PoGoHelper.current_migration}"

  nil
end

bot.run
