class Deletecolumnsfrommemberships < ActiveRecord::Migration
  def change
    remove_column :memberships, :upload_count
    remove_column :memberships, :latest_upload_date
  end
end
