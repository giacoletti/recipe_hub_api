class IngredientsRecipe < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingredient

  def name
    ingredient.name
  end
end
