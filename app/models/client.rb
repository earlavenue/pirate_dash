class Client < ActiveRecord::Base

  has_secure_password

  validates :email, uniqueness: true
  validates :email, presence: true
  validates :organization_id, presence: true

  belongs_to :organization
end
