class CreateFantasyLeagues < ActiveRecord::Migration
  def change
    create_table :fantasy_leagues do |t|
      t.references :fantasy_league_site, index: true
      t.string :league_id
      t.string :name

      t.timestamps
    end
  end
end
