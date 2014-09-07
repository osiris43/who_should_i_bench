class CreateNflGameReceivingStats < ActiveRecord::Migration
  def change
    create_table :nfl_game_receiving_stats do |t|
      t.references :nfl_player, index: true
      t.references :nfl_game, index: true
      t.integer :receptions
      t.integer :yards
      t.integer :tds
      t.integer :longest
      t.integer :targets

      t.timestamps
    end
  end
end
