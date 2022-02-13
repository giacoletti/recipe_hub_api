class Recipe::ShowSerializer < ActiveModel::Serializer
  attributes :id, :name, :instructions, :ingredients, :created_at, :owner
  has_many :ingredients, serializer: Ingredient::ShowSerializer

  def created_at
    object.created_at.to_formatted_s(:long)
  end

  def owner
    object.user.email
  end
end
