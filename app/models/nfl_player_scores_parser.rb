class NflPlayerScoresParser
  def parse_weekly_scores(data, week, season, mfl_league)
    scores = data['playerScores']['playerScore']
    scores.each do |s|
      player = NflPlayer.where(:myfantasyleagueid => s['id']).first
       
      if player.nil?
        puts "Player Not found:#{s}"
      end

      player.scores.create!(:season => season, :week => week, :score => s['score'].to_f,
                            :fantasy_league_id => mfl_league.id) unless player.nil?
    end
  end
end
