require 'pogo_stats/stats/entry'
require 'pogo_stats/stats/mapper'

require 'pogo_stats/stats/comparison_selector'

require 'pogo_stats/stats/base'
require 'pogo_stats/stats/player'
require 'pogo_stats/stats/medals'
require 'pogo_stats/stats/overall'

require 'pogo_stats/presenter/players'
require 'pogo_stats/presenter/player'

require 'pogo_stats/renderer/top_player'
require 'pogo_stats/renderer/invalid_comparison'
require 'pogo_stats/renderer/invalid_arguments'

require 'pogo_stats/value_object/player_statistics'
require 'pogo_stats/value_object/stats'
require 'pogo_stats/value_object/players'


module PogoStats
  module Stats
    class InvalidComparison < Exception; end
    class InvalidArguments < Exception; end
  end
end
