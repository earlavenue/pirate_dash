# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
PirateMetricsDashboard::Application.initialize!

ActionMailer::Base.smtp_settings = {
  :user_name => ENV['CWDASH_SENDGRID_USERNAME'],
  :password => ENV['CWDASH_SENDGRID_PASSWORD'],
  :domain => 'heroku.com',
  :address => 'smtp.sendgrid.net',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}
