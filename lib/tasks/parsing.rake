task :parse_teams => :environment do
  parser = NflTeamsParser.new
  parser.parse_teams()
end

task :parse_rosters => :environment do
  parser = NflRosterParser.new
  parser.parse_players()
end

task :parse_games, [:week, :season] => [:environment] do |t, args|
  week = args.week
  season = args.season
  require 'open-uri'
  require 'nokogiri'
  scoreboard = Nokogiri::HTML(open("http://scores.espn.go.com/nfl/scoreboard?seasonYear=#{season}&seasonType=2&weekNumber=#{week}"))
  scoreboard.css('div.game-links').each do |link|
    boxscore = link.css('a')[1]['href'] unless link.css('a')[1].content != "Box Score"
    puts boxscore
    parser = EspnNflGameParser.new("http://scores.espn.go.com#{boxscore}")
    parser.parse
  end
end
