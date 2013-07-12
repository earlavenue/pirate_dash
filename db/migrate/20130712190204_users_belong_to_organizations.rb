class UsersBelongToOrganizations < ActiveRecord::Migration
  def change
    add_column :users, :organization_id, :integer
    add_column :people, :organization_id, :integer
    remove_column :users, :organization
    remove_column :people, :organization
  end
end
