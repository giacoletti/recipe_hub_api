FactoryBot.define do
  factory :ingredient do
    amount { 2.5 }
    unit { 'dl' }
    name { 'sugar' }
    recipe
  end
end
