class Recipe::IndexSerializer < ActiveModel::Serializer
  attributes :id, :title, :instructions, :created_at, :updated_at
end
