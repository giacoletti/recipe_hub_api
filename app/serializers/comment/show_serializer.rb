class Comment::ShowSerializer < ActiveModel::Serializer
  attributes :body, :user
  belongs_to :user
end
