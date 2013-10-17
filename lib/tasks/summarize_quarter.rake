desc "Store the number of activations for a model in a given quarter"
task :summarize_quarter, [:start_date, :device_model] => [:environment] do |t, args|
  start_date = args[:start_date].to_date
  end_date = start_date + 3.months
  device_model = args[:device_model]

  activations = Upload.find_by_sql(['select count(*) as total from (select device_model, device_serial, min(date) as first_upload from of_of_measurements group by device_serial having (first_upload between ? AND ?) AND (device_model = ?)) as count', start_date, end_date, device_model]).first.total

  s = QuarterSummary.new
  s.start_date = start_date
  s.device_model = device_model
  s.activations = activations
  s.save
end
