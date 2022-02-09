FactoryBot.define do
  factory :recipe_ingredient do
    ingredient
    recipe
    unit { 'grams' }
    amount { 200 }
  end
end
