class CreateNflPlayerScores < ActiveRecord::Migration
  def change
    create_table :nfl_player_scores do |t|
      t.references :nfl_player, index: true
      t.integer :season
      t.integer :week
      t.float :score

      t.timestamps
    end
  end
end
