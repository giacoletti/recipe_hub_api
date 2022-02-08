class IngredientsRecipe < ApplicationRecord
  validates_presence_of :amount, :unit
  belongs_to :recipe
  belongs_to :ingredient

  def name
    ingredient.name
  end
end
