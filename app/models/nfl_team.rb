class NflTeam < ActiveRecord::Base
  has_many :nfl_players


  def find_player(lastname, firstname, position=nil)
    exceptions = {"Dujuan" => "DuJuan"}
    if exceptions.include?(lastname)
      lastname = exceptions[lastname]
    end
    if exceptions.include?(firstname)
      firstname = exceptions[firstname]
    end
    if position.nil?
      return nfl_players.where(:lastname => lastname).first
    else
      NflPlayer.joins(:position).where(nfl_positions: {abbreviation: position}, lastname: lastname).first
    end
  end
end
