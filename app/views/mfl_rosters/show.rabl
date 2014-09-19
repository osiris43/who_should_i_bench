collection @players
attributes :firstname, :lastname
child(:position){attributes :abbreviation}
child(:team){attributes :city, :mascot, :abbreviation}
node(:points_scored){|player| player.points_scored_by_mfl_league(@league)}
