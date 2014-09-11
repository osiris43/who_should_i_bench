class NflTeamsController < ApplicationController
  def index
    @teams = NflTeam.all.to_a
    render json: @teams,:callback => params['callback']
  end

  def new
  end

  def create
  end

  def show
  end
end
