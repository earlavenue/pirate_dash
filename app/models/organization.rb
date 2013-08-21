class Organization < ActiveRecord::Base
  attr_accessible :address, :city, :name, :state, :zip, :code
  validates :name, :presence => true
  validates :name, :uniqueness => true
  validates :code, :presence => true
  validates :code, :uniqueness => true

  has_many :memberships
  has_many :people, through: :memberships
  has_many :clients
end
