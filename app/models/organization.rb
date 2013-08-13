class Organization < ActiveRecord::Base
  attr_accessible :address, :city, :name, :state, :zip

  has_many :memberships
  has_many :people, through: :memberships
  has_many :clients
end
