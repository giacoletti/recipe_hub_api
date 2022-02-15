class Recipe < ApplicationRecord
  validates_presence_of :name, :instructions
  scope :by_recently_created, -> { order(created_at: :desc) }
  has_many :ingredients, class_name: 'RecipeIngredient'
  belongs_to :user
  has_many :comments
  accepts_nested_attributes_for :ingredients
  has_one_attached :image

  def image_serialized
    if Rails.env.test?
      ActiveStorage::Blob.service.path_for(image.key)
    else
      image.url(expires_in: 1.hour,
                disposition: 'inline')
    end
  end

  def fork(user)
    forked_recipe = dup
    forked_recipe.user = user
    forked_recipe.save
    if ingredients
      ingredients.each do |ingredient|
        forked_recipe.ingredients.create(ingredient: ingredient.ingredient, amount: ingredient.amount,
                                         unit: ingredient.unit)
      end
    end
    update(forks_count: forks_count + 1)
    forked_recipe
  end
end
