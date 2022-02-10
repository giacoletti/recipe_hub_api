class Recipe::IndexSerializer < ActiveModel::Serializer
  attributes :id, :name, :instructions, :created_at, :updated_at, :user

  def created_at
    object.created_at.to_formatted_s(:long)
  end

  def updated_at
    object.created_at.to_formatted_s(:long)
  end

  def user
    object.user.email
  end
end
