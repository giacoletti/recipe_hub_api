class Recipe::ShowSerializer < ActiveModel::Serializer
  attributes :id, :title, :instructions, :ingredients
  belongs_to :ingredients, serializer: Ingredient::ShowSerializer
end
