FactoryBot.define do
  factory :ingredients_recipe do
    ingredient
    recipe
    unit { 'grams' }
    amount { 200 }
  end
end
