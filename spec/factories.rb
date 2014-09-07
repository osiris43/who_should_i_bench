FactoryGirl.define do
  factory :nfl_player do
    firstname "Tony"
    lastname  "Romo"
    position :nfl_position
    team :nfl_team
  end

  factory :nfl_team do
    city "Dallas"
    mascot "Cowboys"
    abbreviation "DAL"
    
    # team_with_players will create post data after the team has been created
    factory :team_with_players do
      # posts_count is declared as a transient attribute and available in
      # attributes on the factory, as well as the callback via the evaluator
      transient do
        players_count 1
      end

      # the after(:create) yields two values; the team instance itself and the
      # evaluator, which stores all values from the factory, including transient
      # attributes; `create_list`'s second argument is the number of records
      # to create and we make sure the team is associated properly to the player
      after(:create) do |team, evaluator|
        create_list(:nfl_player, evaluator.players_count, team: team)
      end
    end
  end


  factory :nfl_position do
    abbreviation  "QB"
  end
end
