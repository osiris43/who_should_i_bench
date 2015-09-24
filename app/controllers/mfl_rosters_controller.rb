class MflRostersController < ApplicationController
  require 'open-uri'


  def index
    league = params[:mfl_league_id]
    franchises = get_franchises(league)
    
    render json: franchises.as_json(only: ["id", "name"]), :callback => params['callback']

  end

  def show
    @league = params[:mfl_league_id]

    data1 = get_data_from_mfl("http://football4.myfantasyleague.com/2014/export?TYPE=rosters&L=#{@league}&W=&JSON=1")
    rosters = data1['rosters']['franchise']
    roster = rosters.select{|r| r['id'] == params['id']}.first

    playerids = roster['player'].collect{|p| p["id"]}
    @players = NflPlayer.where(:myfantasyleagueid => playerids).all

    render "mfl_rosters/show"
  end

  def get_data_from_mfl(url)
    @fl = open(URI.encode(url))
    JSON.parse(@fl.read())
  end

  def get_franchises(league)
    data = get_data_from_mfl("http://football4.myfantasyleague.com/2014/export?TYPE=league&L=#{league}&W=&JSON=1")
    franchises = data['league']['franchises']['franchise']
    return franchises
  end
end
