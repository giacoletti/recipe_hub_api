class Ingredient::ShowSerializer < ActiveModel::Serializer
  attributes :amount, :unit, :name
end
