def player_info(row)
  {
    name: row[0],
    player_tag: row[1],
    team: row[2],
    discord_tag: row[3],
    start_date: row[4],
    level_40_date: row[5],
    current_level: row[6],
    total_xp: (row[8].nil?) ? nil : row[8].delete(',').to_i,
    pokemon_seen: row[9],
    pokemon_caught: row[10],
  }
end

def player_medals(row) 
  {
    collectors: row[11],
    jogger: row[12],
    scientist: row[13],
    breeder: row[14],
    backpacker: row[15],
    battle_girl: row[16],
    ace_trainer: row[17],
    youngster: row[18],
    pikachu_fan: row[19],
    fisherman: row[20],
    berry_master: row[21],
    gym_leader: row[22],
    champion: row[23],
    battle_legend: row[24],
    total_unique_unown: row[25]
  }
end

def player_overall_stats(row)
  {
    total_perfect_pokemon: row[26],
    total_gyms: row[27],
    total_golds_pokemon_per_type1: row[28],
    total_golds_pokemon_per_type: row[29],
    last_updated: row[30]
  }
end

def print_player_medals(stats)
  """
Name: #{stats[:player_tag]}

Collectors: #{stats[:collectors]}
Jogger: #{stats[:jogger]}
Scientist: #{stats[:scientist]}
Breeder: #{stats[:breeder]}
Backpacker: #{stats[:backpacker]}
Battle Girl: #{stats[:battle_girl]}
Ace Trainer: #{stats[:ace_trainer]}
Youngster: #{stats[:youngster]}
Pikachu Fan: #{stats[:pikachu_fan]}
Fisherman: #{stats[:fisherman]}
Berry Master: #{stats[:berry_master]}
Gym Leader: #{stats[:gym_leader]}
Champion: #{stats[:champion]}
Battle Legend: #{stats[:battle_legend]}
Total Unique Unown: #{stats[:total_unique_unown]}
  """
end

def print_player_stats(stats)
  """
Name: #{stats[:player_tag].capitalize} (#{stats[:team].capitalize})

Start Date: #{stats[:start_date]}
Level 40 Completion Date: #{stats[:level_40_date]}
Current Level: #{stats[:current_level]}

Total XP: #{stats[:total_xp]}

Pokemon Seen: #{stats[:pokemon_seen]}
Pokemon Caught: #{stats[:pokemon_caught]}
  """
end

