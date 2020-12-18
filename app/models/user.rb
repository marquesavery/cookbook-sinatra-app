class User < ActiveRecord::Base
    validates_presence_of :email
    validates_uniqueness_of :email, :message
    has_secure_password
    has_many :recipes 
    has_many :ingredients
  
    def slug
      username.downcase.split(" ").join("-")
    end
  
    def self.find_by_slug(username)
        User.all.find {|u| u.slug == username}
    end
  end
  