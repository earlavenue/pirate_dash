every 3.months do
  rake "create_previous_quarter_personquarter_records"

  rake 'cache_previous_quarter_device_quarters'
end

# Reset the cache (at 12:00AM on the first of: Feb, May, Aug, Nov) for late activations.
every '0 0 1 2,5,8,11 *' do
  rake 'cache_previous_quarter_device_quarters'
end
