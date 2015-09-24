class NflPlayer < ActiveRecord::Base
  belongs_to :position, :foreign_key => "nfl_position_id", :class_name => "NflPosition"
  belongs_to :team, :foreign_key => "nfl_team_id", :class_name => "NflTeam"
  has_many :scores, :class_name => "NflPlayerScore" 
  has_many :nfl_game_rushing_stats

  validates_presence_of :firstname, :lastname, :team, :position


  def self.from_mfljson data
    name = data['name'].split(',')
    abbv = data['team']
    team = NflTeam.find_by_abbreviation(abbv)
    if team.nil?
      team = NflTeam.create!(:city => "", :mascot => "", :abbreviation => data['team'])
    end
    pos = NflPosition.find_by_abbreviation(data['position'])
    if pos.nil?
      pos = NflPosition.create!(:abbreviation => data['position'])
    end
  
    NflPlayer.find_or_initialize_by(:nfl_team_id => team.id, :nfl_position_id => pos.id, :lastname => name[0]) do |p|
      p.lastname = name[0]
      p.firstname = name[1].strip
      p.myfantasyleagueid = data['id']
      p.save
    end
  end

  def points_scored_by_mfl_league(league)
    scores.inject(0){|sum, n| sum + n.score }.round(2)
  end

  def projected_points(season, week)
    if nfl_game_rushing_stats.count == 0
      return 0.0
    end
  end

  def rushing_avg_by_season_week(season, week)
    stats = nfl_game_rushing_stats.joins(:nfl_game).where("nfl_games.season = ? AND nfl_games.week < ?", season, week)

    stats.inject(0){|acc, stat| acc + stat.yards} / stats.count
  end
end
