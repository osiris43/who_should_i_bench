task :parse_teams => :environment do
  parser = NflTeamsParser.new
  parser.parse_teams()
end

task :parse_rosters => :environment do
  parser = NflRosterParser.new
  parser.parse_players()
end

task :parse_games => :environment do
  parser = EspnNflGameParser.new('spec/models/gb_at_sea.html')
  parser.parse
end
