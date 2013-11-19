desc "Cache and set the Device Quarter records for the previous quarters"
task :cache_previous_quarter_device_quarters => [:environment] do

  models = ['HJ-720', 'HJA-312', 'HJ-322']
  previous_quarter = Time.now.to_date.beginning_of_quarter - 3.months
  models.each do |model|
    Rails.cache.write("#{model}_#{previous_quarter}", Upload.current_quarter_activations(model, previous_quarter))
  end
end
