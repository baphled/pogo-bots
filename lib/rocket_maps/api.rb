require 'httparty'

class RocketMapsApi
  include HTTParty

  headers 'referer' => 'http://mysite.com'
  base_uri ENV['ROCKET_MAPS']

  def self.raw_data_request
    data = {
      data: {
        'pokemon': false,
        'pokestops': false,
        'gyms': true,
        'scanned': false,
        'seen': false,
      }
    }
    get('/raw_data', data).response.body
  end

  def self.raw_data
    JSON.parse(raw_data_request)
  end
end
