class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |u|
      u.string :name
      u.text :bio
      u.string :email
      u.string :username
      u.string :password_digest
    end
  end
end
