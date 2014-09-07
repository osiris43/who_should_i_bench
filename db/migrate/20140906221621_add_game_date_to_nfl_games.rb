class AddGameDateToNflGames < ActiveRecord::Migration
  def change
    add_column :nfl_games, :gamedate, :datetime
  end
end
