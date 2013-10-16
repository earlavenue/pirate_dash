desc "Add Data to the Device Model Column"
task :HJ322_device   => [:environment] do


  upload_table = Upload.find_by_sql(['select device_serial, date from of_of_measurements where device_serial LIKE ?', "0002%"])

  upload_table.each do |row|
    new_upload = Upload.where(device_serial: row.device_serial).where(date: row.date).first
    new_upload.device_model= "HJ-322"
    new_upload.save
    end

end
