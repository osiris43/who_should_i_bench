class NflPositionsController < ApplicationController
  def index
    @positions = NflPosition.all

    render json: @positions
  end

  def new
  end

  def create
  end

  def show
  end
end
