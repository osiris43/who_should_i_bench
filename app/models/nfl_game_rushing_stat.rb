class NflGameRushingStat < ActiveRecord::Base
  belongs_to :nfl_player
  belongs_to :nfl_game
end
