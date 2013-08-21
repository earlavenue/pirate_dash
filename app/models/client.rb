class Client < ActiveRecord::Base
  attr_accessible :email, :password_digest, :password, :password_confirmation, :first_name, :last_name, :organization_id

  has_secure_password

  validates :email, uniqueness: true
  validates :email, presence: true
  validates :organization_id, presence: true

  belongs_to :organization
end
