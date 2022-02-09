class Recipe < ApplicationRecord
  validates_presence_of :name, :instructions
  scope :by_recently_created, -> { order(created_at: :desc) }
  has_many :ingredients, class_name: 'RecipeIngredient'
end
