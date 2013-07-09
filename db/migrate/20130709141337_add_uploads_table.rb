class AddUploadsTable < ActiveRecord::Migration
  def change
    create_table :uploads do |e|
      e.datetime :upload_time
      e.string :dev_serial
    end
  end
end
