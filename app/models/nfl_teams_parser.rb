class NflTeamsParser
  require 'open-uri'
  
  def parse_teams
    @fl = open('http://football.myfantasyleague.com/2014/export?TYPE=players&L=&W=&JSON=1')
    #@fl = open(File.join(Rails.root, "lib", "tasks", "players.json"), "r")
    data = get_team_data
    data.each do |p|
      puts p
      city = p['name'].split(',')[1].strip()
      mascot = p['name'].split(',')[0].strip()
      abbreviation = p['team']

      team = NflTeam.where(:city => city, :mascot => mascot).first
      if team.nil?
        NflTeam.create!(:city => city, :mascot => mascot)
      else
        team.update_attributes(:abbreviation => abbreviation)
        team.save
      end
    end

  end

  def get_team_data
    playerData = JSON.parse(IO.read(@fl))
    playerData['players']['player'].select{|p| p['position']=="TMDL"}
  end
end
