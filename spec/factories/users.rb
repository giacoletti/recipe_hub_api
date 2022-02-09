FactoryBot.define do
  factory :user do
    name { 'John Skoglund' }
    email { 'johnskoglund@email.com' }
    password { '123456789' }
  end
end
