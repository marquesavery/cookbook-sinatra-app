class Ingredient < ActiveRecord::Base
  belongs_to :user
  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients
end
  