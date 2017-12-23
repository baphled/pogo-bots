$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'active_support/inflector/inflections'

require 'pogo_weather/finder'

module PogoWeather
end
