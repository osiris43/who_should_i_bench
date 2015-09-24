class CreateNflTeamRushingStats < ActiveRecord::Migration
  def change
    create_table :nfl_team_rushing_stats do |t|
      t.references :nfl_game, index: true
      t.references :nfl_team, index: true
      t.integer :yards
      t.integer :attempts

      t.timestamps
    end
  end
end
