class Recipe < ApplicationRecord
  validates_presence_of :title, :instructions
end
