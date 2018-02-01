require 'dotenv/load'

require 'discordrb'

require 'pry'

require_relative './lib/rocket_maps'

bot = Discordrb::Commands::CommandBot.new token: ENV['POGO_DISCORD_TOKEN'], prefix: '!'

bot.command(:gyms, description: 'List all the gyms in the area') do |event|
  gyms = RocketMapsGyms.names

  message = ERB.new(<<-BLOCK).result(binding)
<% gyms.each do |gym| %>
<%= gym %>
<% end %>
BLOCK

      event.respond message
end

bot.command(:target, min_args: 1, max_args: 1, description: 'Target a player') do |event, player_name|
  gyms = RocketMapsGyms.target(player_name: player_name)

  if gyms.count >= 1
    message = ERB.new(<<-BLOCK).result(binding)
<%= player_name %> is in the following gyms:
  <% gyms.each do |gym| %>
  <%= gym[:name] %> with a <%= gym[:pokemon]['pokemon_name'] %> (CP <%= gym[:pokemon]['cp_decayed'] %>/<%= gym[:pokemon]['pokemon_cp'] %>)
  <% end %>
    BLOCK
  else
    message = "#{player_name} is not in any gyms"
  end
  event.respond message
end


bot.command(:'gyms-per-team', description: 'Amount of gyms per team') do |event|
  gym_teams = RocketMapsGyms.gyms_per_team

  message = """
Mystic: #{gym_teams[:mystic]}
Valor: #{gym_teams[:valor]}
Instinct: #{gym_teams[:instinct]}
Uncontested: #{gym_teams[:uncontested]}
  """

  event.respond message
end
bot.run
