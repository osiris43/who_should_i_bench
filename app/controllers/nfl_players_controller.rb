class NflPlayersController < ApplicationController
  def show
    @player = NflPlayer.find(params[:id])
    render "nfl_players/show"
  end
end
