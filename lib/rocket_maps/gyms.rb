class RocketMapsGyms
  def self.names
    RocketMapsApi.raw_data['gyms'].collect do |gym_id, gym|
      gym.fetch('name')
    end.compact!.sort!
  end
end
