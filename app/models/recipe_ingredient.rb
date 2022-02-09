class RecipeIngredient < ApplicationRecord
  self.table_name = 'ingredients_recipes'
  validates_presence_of :amount, :unit
  belongs_to :recipe
  belongs_to :ingredient

  def name
    ingredient.name
  end
end
