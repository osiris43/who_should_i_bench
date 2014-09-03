class NflTeamsController < ApplicationController
  def index
    @teams = NflTeam.all.to_a
    logger.debug(@teams)
    render json: @teams
  end

  def new
  end

  def create
  end

  def show
  end
end
