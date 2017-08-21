FactoryGirl.define do
  factory :multi_game do
  	sequence(:draw_date) { |n| "1996-01-#{n}" }
  	result (1..80).to_a.sample(20)
  	cycle nil
  	factory :multi_game_with_cycle do 
  		cycle
  	end
  end
end
