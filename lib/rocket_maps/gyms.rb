class RocketMapsGyms
  def self.names
    RocketMapsApi.raw_data['gyms'].collect do |gym_id, gym|
      gym.fetch('name')
    end.compact.sort!
  end

  def self.target(player_name:)
    gyms = RocketMapsApi.raw_data['gyms']
    gyms.collect do |gym_id, gym|
      found = gym['pokemon'].find do |pokemon|
        pokemon['trainer_name'] == player_name
      end

      if found
        {
          name: gym['name'],
          pokemon: found
        }
      else
        nil
      end
    end.compact!
  end

  def self.gyms_per_team
    teams = {
      mystic: 0,
      valor: 0,
      instinct: 0,
      uncontested: 0,
    }

    RocketMapsApi.raw_data['gyms'].each do |gym_id, gym|
      if gym['team_id'] == 1
        teams[:mystic] += 1
      elsif gym['team_id'] == 2
        teams[:valor] += 1
      elsif gym['team_id'] == 3
        teams[:instinct] += 1
      else
        teams[:uncontested] += 1
      end
    end

    teams
  end
end
