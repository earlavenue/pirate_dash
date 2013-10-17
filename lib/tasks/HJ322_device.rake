desc "Add Data to the Device Model Column"
task :HJ322_device   => [:environment] do

  uploads322 = Upload.where("device_serial LIKE ? AND device_model = ?", "0002%", nil)
  uploads322.each do |upload|
    upload.device_model = "HJ-322"
    upload.save
  end

end
