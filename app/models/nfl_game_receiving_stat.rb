class NflGameReceivingStat < ActiveRecord::Base
  belongs_to :nfl_player
  belongs_to :nfl_game
end
