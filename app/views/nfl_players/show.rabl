object @player
attributes :firstname, :lastname, :id
child(:position){attributes :abbreviation}
child(:team){attributes :city, :mascot, :abbreviation}
