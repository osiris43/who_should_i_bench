class CreateNflTeams < ActiveRecord::Migration
  def change
    create_table :nfl_teams do |t|
      t.string :city
      t.string :mascot

      t.timestamps
    end
  end
end
