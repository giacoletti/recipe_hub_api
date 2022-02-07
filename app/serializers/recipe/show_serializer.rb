class Recipe::ShowSerializer < ActiveModel::Serializer
  attributes :id

def amount
  object.amount
end


end
