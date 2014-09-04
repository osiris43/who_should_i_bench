class CreateNflPlayers < ActiveRecord::Migration
  def change
    create_table :nfl_players do |t|
      t.references :nfl_team, index: true
      t.string :firstname
      t.string :lastname
      t.references :nfl_position, index: true
      t.string :myfantasyleagueid

      t.timestamps
    end
  end
end
