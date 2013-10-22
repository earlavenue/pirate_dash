desc "Store the number of activations for a model in a given quarter"
task :create_device_quarters => [:environment] do

  device_models = ["HJ-720", "HJA-312", "HJ-322"]
  start_dates_as_strings = ["Jan 1, 2011", "Apr 1, 2011", "July 1, 2011", "October 1, 2011", "Jan 1, 2012", "Apr 1, 2012", "July 1, 2012", "October 1, 2012", "Jan 1, 2013", "Apr 1, 2013", "July 1, 2013"]
  start_dates = start_dates_as_strings.map { |d| d.to_date }

  device_models.each do |model|

    start_dates.each do |start_date|

      end_date = start_date + 3.months

      activations = Upload.find_by_sql(['select count(*) as total from (select device_model, device_serial, min(date) as first_upload from of_of_measurements group by device_serial having (first_upload between ? AND ?) AND (device_model = ?)) as count', start_date, end_date, model]).first.total

      s = DeviceQuarter.new
      s.start_date = start_date
      s.device_model = model
      s.activations = activations
      s.save

    end

  end

end
