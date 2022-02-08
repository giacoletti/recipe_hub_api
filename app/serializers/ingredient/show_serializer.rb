class Ingredient::ShowSerializer < ActiveModel::Serializer
  attributes :name, :amount, :unit
end
