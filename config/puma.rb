# THREAD_POOL = ENV['THREAD_POOL'] || 4
THREAD_POOL = 4

workers 3
threads THREAD_POOL,THREAD_POOL
preload_app!

on_worker_boot do
  ActiveSupport.on_load(:active_record) do
    config = Rails.application.config.database_configuration[Rails.env]
    config['reaping_frequency'] = 10 # seconds
    config['pool'] = THREAD_POOL
    ActiveRecord::Base.establish_connection(config)
  end

end
