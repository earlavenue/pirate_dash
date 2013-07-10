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

  def self.aggregate_activations(time)
    Upload.where("upload_time < '#{time}'").select("DISTINCT(dev_serial)").count
  end

end
