FactoryBot.define do
  factory :recipe do
    name { 'Fried rice with kimchi' }
    instructions { 'Mix everything' }
    user 
  end
end
