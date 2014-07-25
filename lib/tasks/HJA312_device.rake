desc "Add Data to the Device Model Column"
task :HJA312_device   => [:environment] do

  uploads312 = Upload.where("device_serial LIKE ?", "HJA%")
  uploads312.each do |upload|
    upload.device_model = "HJA-312"
    upload.save
  end

end
