class AddFantasyLeagueToNflPlayerScore < ActiveRecord::Migration
  def change
    add_column :nfl_player_scores, :fantasy_league_id, :integer
  end
end
