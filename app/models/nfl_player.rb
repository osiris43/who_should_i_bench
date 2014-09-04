class NflPlayer < ActiveRecord::Base
  belongs_to :nfl_team
  belongs_to :nfl_position
  
  validates_presence_of :firstname, :lastname, :nfl_team, :nfl_position

  def from_json data
    name = data['name'].split(',')
    abbv = data['team']
    team = NflTeam.find_by_abbreviation(abbv)
    pos = NflPosition.find_by_abbreviation(data['position'])
    if pos.nil?
      pos = NflPosition.create!(:abbreviation => data['position'])
    end
    update_attributes(:lastname => name[0],:firstname => name[1].strip, :nfl_team => team, :nfl_position => pos,
                      :myfantasyleagueid => data['id'])
  end
end
