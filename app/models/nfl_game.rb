class NflGame < ActiveRecord::Base
  belongs_to :nfl_season_type
  has_many :nfl_game_rushing_stats
  has_many :nfl_team_rushing_stats
  belongs_to :away_team, :foreign_key => 'away_team_id', :class_name => 'NflTeam'
  belongs_to :home_team, :foreign_key => 'home_team_id', :class_name => 'NflTeam'

  def rushing_yards_allowed(team)
    #opponent = away_team == team ? home_team : away_team
    #nfl_team_rushing_stats.where(:nfl_team => opponent).first.yards
    nfl_team_rushing_stats.where(:nfl_team => team).first.yards
  end
end
