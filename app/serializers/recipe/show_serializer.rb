class Recipe::ShowSerializer < ActiveModel::Serializer
  attributes :id, :title, :instructions, :ingredients, :created_at
  belongs_to :ingredients, serializer: Ingredient::ShowSerializer

  def created_at
    object.created_at.to_formatted_s(:long)
  end
end
