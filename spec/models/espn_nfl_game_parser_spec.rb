require 'spec_helper'

describe EspnNflGameParser do
  it "gets the game date" do
    @location = 'spec/models/gb_at_sea.html'
    parser = EspnNflGameParser.new(@location)
    doc = Nokogiri::HTML(open(@location))
    parser.get_game_date.year.should == 2014
    parser.get_game_date.day.should == 4
  end
end

