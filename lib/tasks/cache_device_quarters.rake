desc "Cache Device Quarters"
task :cache_device_quarters => [:environment] do

  start_date = "2011/01/01".to_date
  11.times do
    model = "HJ-720"
    Rails.cache.write("#{model}_#{start_date}", DeviceQuarter.where(:device_model => model).where(:start_date => start_date).first.activations)
    start_date += 3.months
  end


  start_date = "2011/01/01".to_date
  11.times do
    model = "HJ-322"
    Rails.cache.write("#{model}_#{start_date}", DeviceQuarter.where(:device_model => model).where(:start_date => start_date).first.activations)
    start_date += 3.months
  end


  start_date = "2011/01/01".to_date
  11.times do
    model = "HJA-312"
    Rails.cache.write("#{model}_#{start_date}", DeviceQuarter.where(:device_model => model).where(:start_date => start_date).first.activations)
    start_date += 3.months
  end



end
