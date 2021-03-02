class User < ActiveRecord::Base
    validates_presence_of :email, :username
    validates_uniqueness_of :email, message: "Email is already used for another user."
    validates_uniqueness_of :username, message: "Username is taken"
    has_secure_password
    has_many :recipes 
  
    def slug
      username.downcase.split(" ").join("-")
    end
  
    def self.find_by_slug(username)
      User.all.find {|u| u.slug == username}
    end
  end
  