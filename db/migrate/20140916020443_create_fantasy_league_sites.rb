class CreateFantasyLeagueSites < ActiveRecord::Migration
  def change
    create_table :fantasy_league_sites do |t|
      t.string :name

      t.timestamps
    end
  end
end
