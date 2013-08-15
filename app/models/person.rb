class Person < ActiveRecord::Base
  self.table_name = "of_of_users"
  self.primary_key = "user_id"

  has_many :uploads, foreign_key: :user_id, order: 'date ASC'
  has_one :membership
  has_one :organization, through: :membership

  scope :order_by_organization, -> { joins(:organization).order("organizations.name") }

  scope :from_organization, ->(organization_id) { joins(:organization).where("organization_id = ?", organization_id)}

  scope :with_last_name, ->(name) { where("last_name = ?", name) }

  scope :admin_index_view, -> { select("of_of_users.user_id, of_of_users.first_name, of_of_users.last_name, of_of_users.email, organizations.name as organization_name").includes(:uploads) }

  scope :client_index_view, -> { select("of_of_users.user_id, of_of_users.first_name, of_of_users.last_name, of_of_users.email").includes(:uploads) }

  scope :show_page_columns, -> { select("of_of_users.user_id, of_of_users.first_name, of_of_users.last_name, of_of_users.date_created") }

end
