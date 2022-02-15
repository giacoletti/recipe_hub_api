class Comment::ShowSerializer < ActiveModel::Serializer
  attributes :body, :user
  belongs_to :user

  def user
    object.user.name
  end
end
