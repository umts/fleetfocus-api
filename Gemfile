# frozen_string_literal: true

source 'https://rubygems.org'
ruby IO.read(File.expand_path('.ruby-version', __dir__)).strip

gem 'json'
gem 'psych'
gem 'sinatra',              require: 'sinatra/base'
gem 'sinatra-activerecord', require: 'sinatra/activerecord'
gem 'tilt-jbuilder',        require: 'sinatra/jbuilder'

group :production, :development do
  gem 'activerecord-sqlserver-adapter', '~> 6.0.0'
  gem 'tiny_tds', '= 2.1.3'
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
  gem 'capistrano', '~> 3.14', require: false
  gem 'capistrano-bundler',    require: false
  gem 'capistrano-passenger',  require: false
  gem 'capistrano-pending',    require: false
  gem 'irb'
  gem 'pry'
end
