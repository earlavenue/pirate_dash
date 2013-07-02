class User < ActiveRecord::Base
  attr_accessible :email, :password_digest, :password, :password_confirmation, :first_name, :last_name
  has_secure_password
  validates :email, uniqueness: true
end
