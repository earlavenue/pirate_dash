class Upload< ActiveRecord::Base

  belongs_to :person

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      row_hash = row.to_hash
      upload = Upload.new
      upload.dev_serial = row_hash["device_serial"]
      upload.upload_time = row_hash["Date"].gsub(/([0-9]{1,2})\/([0-9]{1,2})\/([0-9]{4})/,"\\3-\\1-\\2") # client csvs will need to have date formatted very carefully/specifically. we can decide whatever format we want to accept (yyyy-mm-dd would be easiest as it would require no gsub) and STICK TO IT.
      upload.person_id = Person.find_by_last_name(row_hash["User Name"].split[1]).id #currently, our "Rush Hospital" csv does not include any unique identifier. In the future, clients will need to provide a csv that includes something like email or dev_serial, etc.
      upload.save!
    end
  end

  def self.aggregate_activations(time)
    Upload.where("upload_time < '#{time}'").select("DISTINCT(dev_serial)").count
  end

end
