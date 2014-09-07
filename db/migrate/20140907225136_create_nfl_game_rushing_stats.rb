class CreateNflGameRushingStats < ActiveRecord::Migration
  def change
    create_table :nfl_game_rushing_stats do |t|
      t.references :nfl_player, index: true
      t.references :nfl_game, index: true
      t.integer :carries
      t.integer :yards
      t.integer :tds
      t.integer :longest

      t.timestamps
    end
  end
end
