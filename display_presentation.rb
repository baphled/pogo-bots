def player_info(row)
  {
    name: row[0],
    player_tag: row[1],
    team: row[2],
    discord_tag: row[3],
    start_date: row[4],
    level_40_date: row[5],
    current_level: row[6],
    total_xp: (row[8].nil?) ? 0 : row[8].delete(',').to_i,
    pokemon_seen: row[9],
    pokemon_caught: row[10],
  }
end

def player_medals(row) 
  {
    collectors: row[11].nil? ? 0 : row[11].delete(',').to_i,
    jogger: row[12].nil? ? 0 : row[12].delete(',').to_i,
    scientist: row[13].nil? ? 0 : row[13].delete(',').to_i,
    breeder: row[14].nil? ? 0 : row[14].delete(',').to_i,
    backpacker: row[15].nil? ? 0 : row[15].delete(',').to_i,
    battle_girl: row[16].nil? ? 0 : row[16].delete(',').to_i,
    ace_trainer: row[17].nil? ? 0 : row[17].delete(',').to_i,
    youngster: row[18].nil? ? 0 : row[18].delete(',').to_i,
    pikachu_fan: row[19].nil? ? 0 : row[19].delete(',').to_i,
    fisherman: row[20].nil? ? 0 : row[20].delete(',').to_i,
    berry_master: row[21].nil? ? 0 : row[21].delete(',').to_i,
    gym_leader: row[22].nil? ? 0 : row[22].delete(',').to_i,
    champion: row[23].nil? ? 0 : row[23].delete(',').to_i,
    battle_legend: row[24].nil? ? 0 : row[24].delete(',').to_i,
    total_unique_unown: row[25].nil? ? 0 : row[25].delete(',').to_i
  }
end

def player_overall_stats(row)
  {
    total_perfect_pokemon: row[26].to_i,
    total_unique_perfect_pokemon: row[27].to_i,
    total_gyms: row[28].to_i,
    total_golds_gyms: row[29].to_i,
    total_golds_pokemon_per_type: row[30].to_i,
    last_updated: row[31]
  }
end

def print_player_medals(stats)
  """
Name: #{stats[:player_tag].capitalize} (#{stats[:team].capitalize})

Collectors: #{stats[:collectors].to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse}
Jogger: #{stats[:jogger].to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse}
Scientist: #{stats[:scientist].to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse}
Breeder: #{stats[:breeder].to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse}
Backpacker: #{stats[:backpacker].to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse}
Battle Girl: #{stats[:battle_girl].to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse}
Ace Trainer: #{stats[:ace_trainer].to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse}
Youngster: #{stats[:youngster].to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse}
Pikachu Fan: #{stats[:pikachu_fan].to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse}
Fisherman: #{stats[:fisherman].to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse}
Berry Master: #{stats[:berry_master].to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse}
Gym Leader: #{stats[:gym_leader].to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse}
Champion: #{stats[:champion].to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse}
Battle Legend: #{stats[:battle_legend].to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse}
Total Unique Unown: #{stats[:total_unique_unown].to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse}
  """
end

def print_player_stats(stats)
  """
Name: #{stats[:player_tag].capitalize} (#{stats[:team].capitalize})

Current Level: #{stats[:current_level]}

Total XP: #{stats[:total_xp].to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse}

Pokemon Caught: #{stats[:pokemon_caught]}
Pokemon Seen: #{stats[:pokemon_seen]}

Total 100% Pokemon: #{stats[:total_perfect_pokemon]}
Total Unique 100% Pokemon: #{stats[:total_unique_perfect_pokemon]}

Start Date: #{stats[:start_date]}

Level 40 Completion Date: #{stats[:level_40_date]}

Last Updated: #{stats[:level_40_date]}
  """
end

def print_compare_players(leader,runner_up, type, string)
  leader_value = leader[type].to_s.gsub(',','').to_i
  runner_up_value = runner_up[type].to_s.gsub(',','').to_i

  difference_between = (leader_value - runner_up_value).to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse

  leader_value = leader[type].to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
  runner_up_value = runner_up[type].to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse

  "#{leader[:player_tag]} is ahead of #{runner_up[:player_tag]} by #{difference_between} (#{leader_value} / #{runner_up_value}) #{string}\n"
end
