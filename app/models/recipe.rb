class Recipe < ActiveRecord::Base
    belongs_to :user
    has_many :recipe_ingredients
    has_many :ingredients, through: :recipe_ingredients

    def slug
        name.downcase.split(" ").join("-")
    end
    
    def self.find_by_slug(name)
        Recipe.all.find {|u| u.slug == name}
    end
end