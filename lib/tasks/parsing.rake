task :parse_teams => :environment do
  parser = NflTeamsParser.new
  parser.parse_teams()
end

task :parse_rosters => :environment do
  parser = NflRosterParser.new
  parser.parse_players()
end
