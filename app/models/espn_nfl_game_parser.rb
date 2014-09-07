class EspnNflGameParser
  require 'open-uri'
  require 'nokogiri'

  def initialize(game_loc)
    @doc = Nokogiri::HTML(open(game_loc))
  end

  def parse
    parse_teams
    @game = get_game
    if @game.nil?
      puts "Game was nil"
    end
    parse_passing
    parse_rushing
  end

  def get_game
    gamedate = get_game_date
    return NflGame.where("away_team_id = ? AND home_team_id = ? AND gamedate BETWEEN ? AND ?", @away.id, @home.id, gamedate.yesterday, gamedate.tomorrow).first
  end

  def get_game_date
    gamedate = @doc.css('div.game-time-location p').first.content
    return DateTime.parse(gamedate)
  end

  def parse_passing
    away = @doc.css('table.mod-data tbody')[1]
    home = @doc.css('table.mod-data tbody')[2]
    parse_passing_data(away, @away)
    parse_passing_data(home, @home)
  end

  def parse_rushing
    away = @doc.css('table.mod-data tbody')[3]
    home = @doc.css('table.mod-data tbody')[4]
    parse_rushing_data(away, @away)
    parse_rushing_data(home, @home)
  end

  def parse_rushing_data(data, team)
    data.css('tr').each do |row|
      data = row.css('td')
      namedata = data[0].css('a')[0]['href'].split('/').last.split("-")
      player = team.find_player(namedata[1].capitalize, namedata[0].capitalize)
      carries = data[1].content
      yards = data[2].content
      tds = data[4].content
      longest = data[5].content
      NflGameRushingStat.create!(:nfl_player => player, :nfl_game => @game,
                                 :carries => carries, :yards => yards,
                                 :tds => tds, :longest => longest)
    end
  end

  def parse_passing_data(data, team)
    data.css('tr').each do |row|
      data = row.css('td')
      namedata = data[0].css('a')[0]['href'].split('/').last.split("-")
      player = team.find_player(namedata[1].capitalize, namedata[0].capitalize)
      completions, attempts = data[1].content.split('/')
      yards = data[2].content
      tds = data[4].content
      interceptions = data[5].content
      sacks, sack_yards = data[6].content.split('-')
      NflGamePassingStat.create!(:nfl_player => player, :nfl_game => @game,
                                 :completions => completions, :attempts => attempts,
                                 :yards => yards, :tds => tds,
                                 :interceptions => interceptions, :sacks => sacks,
                                 :sack_yards => sack_yards)
    end
  end

  def parse_teams
    away, home = @doc.css('title')[0].content.split('-')[0].split('vs.')
    @away = parseteam(away)
    @home = parseteam(home)
  end

  def parseteam(team)
    data = team.strip().split(' ')
    mascot = data[-1]
    city = data.take(data.count-1).join(' ')
    return NflTeam.where(:city => city, :mascot => mascot).first
  end
end
