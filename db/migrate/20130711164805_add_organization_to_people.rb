class AddOrganizationToPeople < ActiveRecord::Migration
  def change
    add_column :people, :organization, :string
    add_column :users, :organization, :string
  end
end
