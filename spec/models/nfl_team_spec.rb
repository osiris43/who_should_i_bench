require 'spec_helper'

describe NflTeam do
  let(:team) {FactoryGirl.create :nfl_team}
  let(:awayteam) {FactoryGirl.create :nfl_team, :city => "Pittsburgh", :mascot => "Steelers" }
  
  it "responds to nfl_players" do
    team.should respond_to(:nfl_players)
  end

  it "looks up player by last name" do
    team.find_player("Romo", "Tony").should.== team.nfl_players.first
  end
  
  it "looks up player by last name and position" do
    team.find_player("Romo", "Tony", "QB").should.== team.nfl_players.first
  end

  it "responds to rushing average by season and week" do
    team.should respond_to(:rushing_average_by_season_week)
  end

  it "calculates rushing average" do
    game1 = FactoryGirl.create :nfl_game
    game2 = FactoryGirl.create :nfl_game
    team.rushing_stats.create!(:nfl_game => game1, :yards => 50, :attempts => 5)
    team.rushing_stats.create!(:nfl_game => game2, :yards => 100, :attempts => 5)
    team.rushing_average_by_season_week(2014, 2).should == 75
  end
  
  it "calculates rushing modifier" do
    game1 = FactoryGirl.create :nfl_game, :home_team => team, :away_team => awayteam, :week => 1
    game2 = FactoryGirl.create :nfl_game, :home_team => team, :away_team => awayteam, :week => 2
    game3 = FactoryGirl.create :nfl_game, :home_team => team, :away_team => awayteam, :week => 3
    
    game1.away_team.rushing_stats.create!(:nfl_game => game1, :yards => 100, :attempts => 5)
    game1.home_team.rushing_stats.create!(:nfl_game => game1, :yards => 50, :attempts => 5)
    
    game2.away_team.rushing_stats.create!(:nfl_game => game2, :yards => 150, :attempts => 5)
    game2.home_team.rushing_stats.create!(:nfl_game => game2, :yards => 75, :attempts => 5)
    

    puts "Target team rushing count is #{team.rushing_stats.count}"
    puts "opponent rushing count is #{game3.away_team.rushing_stats.count}"
    team.rushing_modifier_by_season_week(2014, 3).should == 0.875
  end
end
