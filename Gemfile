# frozen_string_literal: true
source 'https://rubygems.org'

gem 'sinatra',              require: 'sinatra/base'
gem 'sinatra-activerecord', require: 'sinatra/activerecord'

group :production, :development do
  gem 'activerecord-sqlserver-adapter', '~> 4.2.0'
  gem 'tiny_tds'
end

group :test do
  gem 'database_cleaner'
  gem 'factory_girl'
  gem 'rack-test', require: 'rack/test'
  gem 'rspec'
  gem 'rubocop'
  gem 'sqlite3'
end

group :development do
  gem 'capistrano', '=3.4.0', require: false
  gem 'capistrano-bundler',   require: false
  gem 'capistrano-passenger', require: false
  gem 'capistrano-pending',   require: false
  gem 'pry'
end
