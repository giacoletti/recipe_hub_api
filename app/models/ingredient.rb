class Ingredient < ApplicationRecord
  validates_presence_of :name
  has_many :ingredients_recipes
  has_many :recipes, through: :ingredients_recipes
end
