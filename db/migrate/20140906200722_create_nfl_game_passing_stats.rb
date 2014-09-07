class CreateNflGamePassingStats < ActiveRecord::Migration
  def change
    create_table :nfl_game_passing_stats do |t|
      t.references :nfl_player, index: true
      t.references :nfl_game, index: true
      t.integer :completions
      t.integer :attempts
      t.integer :yards
      t.integer :tds
      t.integer :interceptions
      t.integer :sacks
      t.integer :sack_yards

      t.timestamps
    end
  end
end
