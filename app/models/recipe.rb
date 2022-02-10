class Recipe < ApplicationRecord
  validates_presence_of :name, :instructions
  scope :by_recently_created, -> { order(created_at: :desc) }
  has_many :ingredients, class_name: 'RecipeIngredient'
  belongs_to :user
  accepts_nested_attributes_for :ingredients
  has_one_attached :image

  def image_serialized
    if Rails.env.test?
      ActiveStorage::Blob.service.path_for(image.key)
    else
      image.service_url(expires_in: 1.hour,
                        disposition: 'inline')
    end
  end
end
