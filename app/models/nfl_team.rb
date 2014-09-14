class NflTeam < ActiveRecord::Base
  has_many :nfl_players


  def find_player(lastname, firstname, position=nil)
    exceptions = {"Dujuan" => "DuJuan", "Mcfadden" => "McFadden", 
                  "Mckinnon" => "McKinnon", "Mccoy" => "McCoy",
                  "Mccluster" => "McCluster", "Mccown" => "McCown",
                  "Lamichael" => "LaMichael"}
    if exceptions.include?(lastname)
      lastname = exceptions[lastname]
    end
    if exceptions.include?(firstname)
      firstname = exceptions[firstname]
    end
    if position.nil?
      player = nfl_players.where(:lastname => lastname).first
    else
      player = nfl_players.joins(:position).where(nfl_positions: {abbreviation: position}, lastname: lastname).first
    end

    if player.nil?
      player = nfl_players.where("lastname LIKE ? AND firstname LIKE ?", "%#{lastname}%", "%#{firstname}%").first
      if player.nil?
        puts "Lastname:#{lastname}\tFirst:#{firstname}"
      end
    end

    player
  end
end
