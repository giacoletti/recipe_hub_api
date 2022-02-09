Rails.application.routes.draw do
  namespace :api do
    resources :recipes, only: %i[index show update]
  end
end
