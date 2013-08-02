class RenameUsersToClients < ActiveRecord::Migration
  def up
    rename_table :users, :clients
  end

  def down
    rename_table :clients, :users
  end
end
