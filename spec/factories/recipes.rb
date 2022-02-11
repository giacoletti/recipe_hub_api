FactoryBot.define do
  factory :recipe do
    name { Faker::Food.dish }
    instructions { Faker::Food.description }
    user
    after(:build) do |recipe|
      recipe.image.attach(
        io: File.open(Rails.root.join('spec', 'fixtures', 'carbonara.jpeg')),
        filename: 'carbonara.jpeg',
        content_type: 'image/jpeg'
      )
    end
  end
end
