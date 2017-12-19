$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'pogo_stats/spreadsheet'
require 'pogo_stats/competition'
require 'pogo_stats/stats'

require 'yaml'
require 'logger'
require 'active_record'

require 'active_support/inflector/inflections'

root = File.expand_path '../..', __FILE__
db_config = YAML.load(File.read(File.join(root, 'db/config.yml')))
environment = ENV['ENV'] || 'development'
ActiveRecord::Base.establish_connection(db_config[environment])
