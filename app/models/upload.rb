class Upload< ActiveRecord::Base

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      row_hash = row.to_hash
      upload = Upload.new
      upload.dev_serial = row_hash["device_serial"]
      upload.upload_time = row_hash["server_time"]
      upload.save!
    end
  end


### Right now we can get a array of distinct device's first uploads. To display it - it takes 5 minutes. So that's a problem. We need to write two methods that can return to us the aggregate count of unique uploads each month and the discreet count of unique uploads each month.

###...Or something like that....

  # def self.first_instances
  #   unique_devices = Upload.select("DISTINCT(dev_serial)")
  #   array_of_first_instances = []
  #   unique_devices.each do |device|
  #     array_of_first_instances << Upload.where(dev_serial: device.dev_serial).order("upload_time ASC").limit(1).first
  #   end

  #   january = []
  #   february = []
  #   march = []
  #   april = []
  #   may = []
  #   june = []
  #   july = []
  #   august = []
  #   september = []
  #   october = []
  #   november = []
  #   december = []
  #   array_of_first_instances.each do |upload|
  #     if upload.upload_time.month == 1
  #       january << upload


  #   return array_of_first_instances
  # end

end