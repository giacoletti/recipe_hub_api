class AddForksCountToRecipes < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :forks_count, :integer, default: 0
  end
end
