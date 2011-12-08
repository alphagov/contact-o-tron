source :rubygems

gem 'rails', '3.1.1'

group :passenger_compatibility do
  gem 'rack', '1.3.5'
  gem 'rake', '0.9.2'
end

if ENV['BUNDLE_DEV']
  gem 'gds-sso', :path => '../gds-sso'
else
  gem 'warden', '1.0.6'
  gem 'gds-sso', :git => 'git@github.com:alphagov/gds-sso.git'
end

gem 'plek'
gem 'formtastic'
gem 'inherited_resources'
gem 'jquery-rails'
gem 'marples'
gem 'mysql2'
gem 'slimmer'
gem 'stomp'

group :development do
  gem 'nokogiri'
end

group :test do
  gem 'cucumber-rails'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'test-unit'
end
