require 'spec_helper'

describe NflTeam do
  let(:team) {FactoryGirl.create :nfl_team}

  it "responds to nfl_players" do
    team.should respond_to(:nfl_players)
  end

  it "looks up player by last name" do
    team.find_player("Romo", "Tony").should.== team.nfl_players.first
  end
  
  it "looks up player by last name and position" do
    team.find_player("Romo", "Tony", "QB").should.== team.nfl_players.first
  end
end
