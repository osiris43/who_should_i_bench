class NflTeam < ActiveRecord::Base
  has_many :nfl_players

  has_many :away_games, :class_name => "NflGame", :foreign_key => "away_team_id"
  has_many :home_games, :class_name => "NflGame", :foreign_key => "home_team_id"
  has_many :rushing_stats, :class_name => "NflTeamRushingStat"

  def find_player(lastname, firstname, position=nil)
    exceptions = {"Dujuan" => "DuJuan", "Mcfadden" => "McFadden", 
                  "Mckinnon" => "McKinnon", "Mccoy" => "McCoy",
                  "Mccluster" => "McCluster", "Mccown" => "McCown",
                  "Lamichael" => "LaMichael", "Dimarco" => "DiMarco",
                  "Lafell" => "LaFell", "Mcknight" => "McKnight",
                  "Mcdonald" => "McDonald", "Mcgloin" => "McGloin"}
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

  def rushing_average_by_season_week(season, week)
    puts "rushing stats count is #{rushing_stats.count}"
    stats = rushing_stats.joins(:nfl_game).where("nfl_games.season = ? AND nfl_games.week < ?", season, week)
    if stats.count == 0
      puts "returning zero from average"
      return 0
    end
    stats.inject(0){|sum, stat| sum + stat.yards} / stats.count
  end

  def rushing_modifier_by_season_week(season, week)
    games = away_games.where("season = ? AND week < ?", season, week).all
    games.concat(home_games.where("season = ? AND week < ?", season, week).all)
    acc = 0
    counter = 0 
    games.each do |game|
      if game.away_team.id == id
        opponent = game.home_team
      else
        opponent = game.away_team
      end

      avg = opponent.rushing_average_by_season_week(season, game.week)
      puts "Opponent: #{opponent.city} rushing average: #{avg}"
      if avg == 0
        acc += 1.0
      else
        puts "#{self.city}"
        actual = game.rushing_yards_allowed(self)
        puts "actual was #{actual}"
        acc += actual.to_f / avg
      end

      puts "accumulator was #{acc}"
      counter += 1
    end

    result = acc.to_f / counter unless counter == 0
    puts "result was #{result}"

    result
  end
end
