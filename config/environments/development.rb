PirateMetricsDashboard::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.

  config.cache_classes = false

  config.eager_load = false

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

# WILL AND MIKE NOTE: commented out below in accordance with Railscast 415 on upgrading to Rails 4.0

  # # Only use best-standards-support built into browsers
  # config.action_dispatch.best_standards_support = :builtin

  # # Raise exception on mass assignment protection for Active Record models
  # config.active_record.mass_assignment_sanitizer = :strict

  # # Log the query plan for queries taking more than this (works
  # # with SQLite, MySQL, and PostgreSQL)
  # config.active_record.auto_explain_threshold_in_seconds = 0.5

  # # Do not compress assets
  # config.assets.compress = false

  # Added by comparing our app to rails new (rails 4)
  config.active_record.migration_error = :page_load

  # Expands the lines which load the assets
  config.assets.debug = true

  # Forgot Password (In production.rb file we'll need to point this at our domain, i.e. config.action_mailer.default_url_options = { :host => 'cwdash.herokuapp.com' })
  config.action_mailer.default_url_options = { :host => 'localhost:3000' }

end
