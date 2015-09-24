require 'spec_helper'

describe NflPlayer do
  describe "should calculate projections" do
    describe "rushing" do
      let(:rb) {FactoryGirl.create :nfl_player}
      let(:nflgame1) {FactoryGirl.create :nfl_game, :week => 1}
      let(:nflgame2) {FactoryGirl.create :nfl_game, :week => 2}
      
      it "responds to projected_points" do
        expect(rb).to respond_to(:projected_points)
      end

      it "returns zero points for week 1" do
        game = FactoryGirl.create :nfl_game, :home_team => rb.team
        expect(rb.projected_points(2014, 3)).to eq(0.0)
      end

      it "returns rushing average" do
        rb.nfl_game_rushing_stats.create!(:nfl_game => nflgame1, :carries => 5,
                                         :yards => 100, :tds => 1, :longest => 32)
        rb.nfl_game_rushing_stats.create!(:nfl_game => nflgame2, :carries => 10,
                                         :yards => 150, :tds => 1, :longest => 32)

        expect(rb.rushing_avg_by_season_week(2014, 3)).to eq(125)
      end

      it "returns projected points for week 2" do 
        rb.nfl_game_rushing_stats.create!(:nfl_game => nflgame1, :carries => 10,
                                         :yards => 150, :tds => 1, :longest => 32)
        expect(rb.projected_points(2014,3)).to eq(45)
      end
    end
  end
end
