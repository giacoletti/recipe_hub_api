class Recipe::ShowSerializer < ActiveModel::Serializer
  attributes :id, :title, :instructions, :ingredients, :created_at

  def created_at
    object.created_at.to_formatted_s(:long)
  end

  # def ingredients
  #   binding.pry
  #   object.ingredients
  # end
end
