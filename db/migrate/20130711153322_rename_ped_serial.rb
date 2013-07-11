class RenamePedSerial < ActiveRecord::Migration
  def change
    rename_column :people, :pedserial, :dev_serial
  end
end
