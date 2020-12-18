class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |i|
      i.string :name
      i.integer :user_id
    end
  end
end
