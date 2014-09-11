class NflRosterParser
  require 'open-uri'

  def initialize(sb_filelocation=nil)
    if(sb_filelocation.nil?)
      return
    end

    @fl = sb_filelocation
  end

  def parse_players
    if @fl.nil?
      @fl = open('http://football.myfantasyleague.com/2014/export?TYPE=players&L=&W=&JSON=1')
      #@fl = open(File.join(Rails.root, "lib", "tasks", "players.json"), "r")
    end

    data = get_player_data
    data['player'].each do |p|
      puts p
      player = NflPlayer.new
      player.from_json(p)
      player.save
    end

  end

  def get_player_data
    playerData = JSON.parse(IO.read(@fl))
    playerData['players']
  end
end
