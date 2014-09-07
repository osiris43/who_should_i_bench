require 'spec_helper'

describe NflTeamsController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'create'" do
    it "returns http success" do
      get 'create'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    let(:team) { NflTeam.create!(:city => 'Dallas', :mascot => 'Cowboys')}
    it "returns http success" do
      get 'show', :id => team
      response.should be_success
    end
  end

end
