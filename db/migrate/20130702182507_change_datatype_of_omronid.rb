class ChangeDatatypeOfOmronid < ActiveRecord::Migration
  def change
    remove_column :people, :omron_userid
    add_column :people, :omron_userid, :string
  end
end
