class AddIndexes < ActiveRecord::Migration
  def change
    add_index :clients, :organization_id, :name => "client_org_id_ix"
    add_index :memberships, :organization_id, :name => "membership_org_id_ix"
    add_index :memberships, :person_id, :name => "membership_person_id_ix"
  end
end
