class ChangeUploadTimeType < ActiveRecord::Migration
  def up
    change_column :uploads, :upload_time, :date
  end

  def down
    change_column :uploads, :upload_time, :datetime
  end
end
