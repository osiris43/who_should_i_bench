source 'https://rubygems.org'

ruby '2.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.1'


gem 'rails-api'

gem 'pg', '~> 0.17.0'
gem 'nokogiri'
gem 'rabl'

group :production do
  gem 'rails_12factor'
end

group :development, :test do
  gem 'rspec-rails'
end

group :test do
  gem 'webrat'
  gem 'mocha', :require => false
  gem "factory_girl_rails", "~> 4.0"
  gem 'guard-rspec'
  gem 'capybara', '1.1.2'
  gem 'rb-fsevent', '0.9.3', :require => false
  gem 'growl'
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano', :group => :development

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
