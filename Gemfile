source :rubygems

gem 'rails', '3.1.1'

group :passenger_compatibility do
  gem 'rack', '1.3.5'
  gem 'rake', '0.9.2'
end

gem 'gds-api-adapters', '0.2.2'
if ENV['BUNDLE_DEV']
  gem 'gds-sso', path: '../gds-sso'
else
  gem 'gds-sso', '~> 1.2.0'
end


gem 'exception_notification'

gem 'gds-warmup-controller'

gem 'aws-ses', :require => 'aws/ses'
gem 'plek'
gem 'formtastic'
gem 'inherited_resources'
gem 'jquery-rails'
gem 'mysql2'
gem 'slimmer', '1.1.47'

group :development do
  gem 'nokogiri'
end

group :test do
  gem 'cucumber-rails'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'test-unit'
end
