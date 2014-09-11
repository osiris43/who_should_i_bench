class NflPlayer < ActiveRecord::Base
  belongs_to :position, :foreign_key => "nfl_position_id", :class_name => "NflPosition"
  belongs_to :team, :foreign_key => "nfl_team_id", :class_name => "NflTeam"
  validates_presence_of :firstname, :lastname, :nfl_team, :nfl_position


  def from_json data
    name = data['name'].split(',')
    abbv = data['team']
    team = NflTeam.find_by_abbreviation(abbv)
    pos = NflPosition.find_by_abbreviation(data['position'])
    if pos.nil?
      pos = NflPosition.create!(:abbreviation => data['position'])
    end
    update_attributes(:lastname => name[0],:firstname => name[1].strip, :team => team, :position => pos,
                      :myfantasyleagueid => data['id'])
  end
end
