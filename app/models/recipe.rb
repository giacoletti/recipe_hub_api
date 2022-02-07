class Recipe < ApplicationRecord
  validates_presence_of :title, :instructions
  scope :by_recently_created, -> { order(created_at: :desc) }
  has_many :ingredients
end
