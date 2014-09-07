class CreateNflGames < ActiveRecord::Migration
  def change
    create_table :nfl_games do |t|
      t.integer :away_team_id
      t.integer :home_team_id
      t.integer :season
      t.integer :week
      t.references :nfl_season_type, index: true

      t.timestamps
    end
  end
end
