task :parse_teams => :environment do
  parser = NflTeamsParser.new
  parser.parse_teams()
end
