class Client < ActiveRecord::Base

  has_secure_password

  validates :email, uniqueness: true, :on => :create
  validates :email, uniqueness: true, :on => :update_profile
  validates :email, uniqueness: true, :on => :update
  validates :email, presence: true, :on => :create
  validates :email, presence: true, :on => :update_profile
  validates :email, presence: true, :on => :update
  validates :organization_id, presence: true, :on => :create
  validates :organization_id, presence: true, :on => :update
  validate :strong_password_create, :on => :create
  validate :strong_password_update, :on => :update
  validate :strong_password_update_password, :on => :update_password

  belongs_to :organization

  def strong_password_create
    unless password.match(/[0-9]/) && password.match(/[A-Z]/) && password.match(/[a-z]/) && password.match(/\!|\@|\#|\$|\%|\^|\&|\*|\(|\)/)
      errors.add(:weak_password, "Password must include a lowercase letter, uppercase letter, number, and symbol.")
    end
  end
  def strong_password_update
    unless password.match(/[0-9]/) && password.match(/[A-Z]/) && password.match(/[a-z]/) && password.match(/\!|\@|\#|\$|\%|\^|\&|\*|\(|\)/)
      errors.add(:weak_password, "Password must include a lowercase letter, uppercase letter, number, and symbol.")
    end
  end
  def strong_password_update_password
    unless password.match(/[0-9]/) && password.match(/[A-Z]/) && password.match(/[a-z]/) && password.match(/\!|\@|\#|\$|\%|\^|\&|\*|\(|\)/)
      errors.add(:weak_password, "Password must include a lowercase letter, uppercase letter, number, and symbol.")
    end
  end
end
