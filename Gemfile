# frozen_string_literal: true

source 'https://rubygems.org'
ruby file: '.ruby-version'

gem 'exception_notification'
gem 'irb'
gem 'json'
gem 'psych'
gem 'puma'
gem 'rails', '~> 7.0.0', install_if: false
gem 'rake'
gem 'sinatra',              require: 'sinatra/base'
gem 'sinatra-activerecord', require: 'sinatra/activerecord'
gem 'tilt-jbuilder',        require: 'sinatra/jbuilder'

group :production, :development do
  gem 'activerecord-sqlserver-adapter'
end

group :test do
  gem 'database_cleaner'
  gem 'factory_bot'
  gem 'rack-test',           require: 'rack/test'
  gem 'rspec'
  gem 'rubocop',             require: false
  gem 'rubocop-rspec',       require: false
  gem 'simplecov',           require: false
  gem 'sqlite3', '~> 1.4.2'
end

group :development do
  gem 'bcrypt_pbkdf', '>= 1.0', '< 2.0', require: false
  gem 'capistrano', '~> 3.14',           require: false
  gem 'capistrano-bundler',              require: false
  gem 'capistrano-passenger',            require: false
  gem 'capistrano-pending',              require: false
  gem 'ed25519', '>= 1.2', '< 2.0',      require: false
end
