class CreateIngredients < ActiveRecord::Migration[6.1]
  def change
    create_table :ingredients do |t|
      t.float :amount
      t.string :unit
      t.string :name

      t.timestamps
    end
  end
end
