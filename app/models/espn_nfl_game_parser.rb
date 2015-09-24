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
    parse_team_stats
    parse_passing
    parse_rushing
    parse_receiving
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

  def parse_receiving
    away = @doc.css('table.mod-data tbody')[5]
    home = @doc.css('table.mod-data tbody')[6]
    parse_receiving_data(away, @away)
    parse_receiving_data(home, @home)
  end
  
  def parse_team_stats
    data = @doc.css('table.mod-data tbody')[0]
    rows = data.css('tr')
    away_passing = rows[10].css('td')[1].content
    home_passing = rows[10].css('td')[2].content
    away_passing_comp, away_passing_att = rows[11].css('td')[1].content.split('-')
    home_passing_comp, home_passing_att = rows[11].css('td')[2].content.split('-')
    away_rushing = rows[15].css('td')[1].content
    home_rushing = rows[15].css('td')[2].content
    away_rushing_att = rows[16].css('td')[1].content
    home_rushing_att = rows[16].css('td')[2].content
    
    NflTeamPassingStat.find_or_initialize_by(:nfl_game => @game, :nfl_team => @game.away_team) do |stat|
      stat.yards = away_passing
      stat.attempts = away_passing_att
      stat.completions = away_passing_comp
      stat.save
    end

    NflTeamPassingStat.find_or_initialize_by(:nfl_game => @game, :nfl_team => @game.home_team) do |stat|
      stat.yards = home_passing
      stat.attempts = home_passing_att
      stat.completions = home_passing_comp
      stat.save
    end

    NflTeamRushingStat.find_or_initialize_by(:nfl_game => @game, :nfl_team => @game.away_team) do |stat|
      stat.yards = away_rushing
      stat.attempts = away_rushing_att
      stat.save
    end
    
    NflTeamRushingStat.find_or_initialize_by(:nfl_game => @game, :nfl_team => @game.home_team) do |stat|
      stat.yards = home_rushing
      stat.attempts = home_rushing_att
      stat.save
    end
  end

  def parse_receiving_data(data, team)
    data.css('tr').each do |row|
      data = row.css('td')
      namedata = data[0].css('a')[0]['href'].split('/').last.split("-")
      player = team.find_player(namedata[1].capitalize, namedata[0].capitalize)
      receptions = data[1].content
      yards = data[2].content
      tds = data[4].content
      longest = data[5].content
      targets = data[6].content
      NflGameReceivingStat.find_or_initialize_by(:nfl_player => player, :nfl_game => @game) do |stat|
        stat.receptions = receptions
        stat.yards = yards
        stat.tds = tds
        stat.longest = longest
        stat.targets = targets
        stat.save
      end
    end
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
      NflGameRushingStat.find_or_initialize_by(:nfl_player => player, :nfl_game => @game) do |stat|
        stat.carries = carries
        stat.yards = yards
        stat.tds = tds
        stat.longest = longest
        stat.save
      end
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
      NflGamePassingStat.find_or_initialize_by(:nfl_player => player, :nfl_game => @game) do |stat|
        stat.completions = completions
        stat.yards = yards
        stat.tds = tds
        stat.attempts = attempts
        stat.sacks = sacks
        stat.interceptions = interceptions
        stat.sack_yards = sack_yards
        stat.save
      end
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
