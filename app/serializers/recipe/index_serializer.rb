class Recipe::IndexSerializer < ActiveModel::Serializer
  attributes :id, :title, :instructions, :created_at, :updated_at

  def created_at
    object.created_at.to_formatted_s(:long)
  end

  def updated_at
    object.created_at.to_formatted_s(:long)
  end
end
