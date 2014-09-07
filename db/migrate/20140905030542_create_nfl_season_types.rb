class CreateNflSeasonTypes < ActiveRecord::Migration
  def change
    create_table :nfl_season_types do |t|
      t.string :description

      t.timestamps
    end
  end
end
