require 'active_record'

require_relative './team_colour_matrix/base'
require_relative './team_colour_matrix/mystic'
require_relative './team_colour_matrix/valor'
require_relative './team_colour_matrix/instinct'

require_relative './team_verification'

require_relative './team_colour_matrix/models/rgb_list'

root = File.expand_path '../..', __FILE__
db_config = YAML.load(File.read(File.join(root, 'db/config.yml')))
environment = ENV['ENV'] || 'development'
ActiveRecord::Base.establish_connection(db_config[environment])
