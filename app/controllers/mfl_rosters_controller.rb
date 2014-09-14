class MflRostersController < ApplicationController
  require 'open-uri'

  def show
    rostername = params[:roster]
    league = params[:id]

    data = get_data_from_mfl("http://football4.myfantasyleague.com/2014/export?TYPE=league&L=#{league}&W=&JSON=1")
    franchises = data['league']['franchises']['franchise']
    franchise = franchises.select{|f| f['name'] == rostername}.first
    
    data1 = get_data_from_mfl("http://football4.myfantasyleague.com/2014/export?TYPE=rosters&L=#{league}&W=&JSON=1")
    rosters = data1['rosters']['franchise']
    roster = rosters.select{|r| r['id'] == franchise['id']}.first

    playerids = roster['player'].collect{|p| p["id"]}
    players = NflPlayer.where(:myfantasyleagueid => playerids).all
    render json: players.as_json(include: {position: {only: :abbreviation},team: {only: [:city, :mascot]}} ), 
      :callback => params['callback']
  end

  def get_data_from_mfl(url)
    @fl = open(URI.encode(url))
    JSON.parse(@fl.read())
  end
end
