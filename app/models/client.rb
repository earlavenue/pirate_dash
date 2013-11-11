class Client < ActiveRecord::Base

  has_secure_password

  validates :email, uniqueness: true
  validates :email, presence: true
  validates :organization_id, presence: true
  validate :strong_password

  belongs_to :organization

  def strong_password
    unless password.match(/[0-9]/) && password.match(/[A-Z]/) && password.match(/[a-z]/) && password.match(/\!|\@|\#|\$|\%|\^|\&|\*|\(|\)/)
      errors.add(:weak_password, "Password must include a lowercase letter, uppercase letter, number, and symbol.")
    end
  end
end
