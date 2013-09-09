source 'https://rubygems.org'

gem 'protected_attributes'
gem 'kaminari'
gem 'mysql2'
gem 'rails', '4.0.0'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

group :development do
  gem 'quiet_assets'
  gem 'thin'
  gem 'debugger'
end

group :production do
  gem 'rainbows'
end


group :development, :test do
  gem 'rspec-rails'
  gem 'capybara'
  gem 'factory_girl_rails'
  gem 'shoulda-matchers'
  gem "launchy", "~> 2.3.0"
  gem "database_cleaner", "~> 1.1.1"
end


# Gems used only for assets and not required
# in production environments by default.
  gem 'sass-rails',   '~> 4.0.0'
  gem 'coffee-rails', '~> 4.0.0'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 2.2.1'


gem 'jquery-rails'

# To use ActiveModel has_secure_password

gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'

#RAILS 4 NOTES:
#BUILDER - Ryan Bates uses the version we're on (3.1.4) even though its at 3.2.2.
#FOR MINITEST - should work in version 4.7.5 as it is now. The newest version of minitest is 5.0.7
#FOR TZINFO - should work in version 0.3.37 but the newest version is 1.0.1
#BCRYPT RUBY - later we need to update to newest version when its compatable with Rails 4.0
#Check later on these gems. Check in with bundle outdated