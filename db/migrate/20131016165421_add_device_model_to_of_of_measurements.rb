class AddDeviceModelToOfOfMeasurements < ActiveRecord::Migration
  def change
    add_column :of_of_measurements, :device_model, :string
  end
end
