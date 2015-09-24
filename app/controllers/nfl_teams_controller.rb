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
    @team = NflTeam.find(params[:id])
    @avg = @team.rushing_average_by_season_week(2014, 3)
    @mod = @team.rushing_modifier_by_season_week(2014, 3)
    render "nfl_teams/show"
  end
end
