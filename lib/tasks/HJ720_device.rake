desc "Add Data to the Device Model Column"
task :HJ720_device   => [:environment] do

  uploads720 = Upload.where("device_serial LIKE ? AND device_model = ?", "HJ720%", nil)
  uploads720.each do |upload|
    upload.device_model = "HJ-720"
    upload.save
  end

end
