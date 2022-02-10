FactoryBot.define do
  factory :recipe do
    name { Faker::Food.dish }
    instructions { Faker::Food.description }
    user 
  end
end
