class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |i|
      i.string :name
    end
  end
end
