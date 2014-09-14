class AddPlayers < ActiveRecord::Migration
  def change
    execute "insert into nfl_players(nfl_team_id, firstname, lastname, nfl_position_id, myfantasyleagueid) " +
      "values(14, 'Gabe', 'Jackson', 14, null)"
    execute "insert into nfl_players(nfl_team_id, firstname, lastname, nfl_position_id, myfantasyleagueid) " +
      "values(32, 'Kamar', 'Aiken', 14, 10651)"
    execute "insert into nfl_players(nfl_team_id, firstname, lastname, nfl_position_id, myfantasyleagueid) " +
      "values(22, 'Michael', 'Spurlock', 14, 8641)"
    execute "insert into nfl_players(nfl_team_id, firstname, lastname, nfl_position_id, myfantasyleagueid) " +
      "values(22, 'Lane', 'Jorvorskie', 23, 10992)"
    execute "insert into nfl_players(nfl_team_id, firstname, lastname, nfl_position_id, myfantasyleagueid) " +
      "values(31, 'LaMichael', 'James', 23, 10711)"
  end
end
