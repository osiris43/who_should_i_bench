class NflTeamRushingStat < ActiveRecord::Base
  belongs_to :nfl_game
  belongs_to :nfl_team
end
