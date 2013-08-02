class Organization < ActiveRecord::Base
  attr_accessible :address, :city, :name, :state, :zip

  has_many :people
  has_many :clients
end
