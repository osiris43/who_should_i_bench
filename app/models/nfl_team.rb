class NflTeam < ActiveRecord::Base
  has_many :nfl_players

  def find_player(lastname, position=nil)
    if position.nil?
      return nfl_players.where(:lastname => lastname).first
    else
      NflPlayer.joins(:position).where(nfl_positions: {abbreviation: position}, lastname: lastname).first
    end
  end
end
