class User < ActiveRecord::Base
  attr_accessible :email, :password_digest, :password, :password_confirmation, :first_name, :last_name, :organization_id
  has_secure_password
  validates :email, uniqueness: true
  belongs_to :organization
end
