class CreateNflPositions < ActiveRecord::Migration
  def change
    create_table :nfl_positions do |t|
      t.string :abbreviation

      t.timestamps
    end
  end
end
