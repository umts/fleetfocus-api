# frozen_string_literal: true

source 'https://rubygems.org'
ruby IO.read(File.expand_path('.ruby-version', __dir__)).strip

gem 'sinatra',              require: 'sinatra/base'
gem 'sinatra-activerecord', require: 'sinatra/activerecord'

group :production, :development do
  gem 'activerecord-sqlserver-adapter', '~> 5.2.0'
  gem 'tiny_tds', '= 2.1.2'
end

group :test do
  gem 'database_cleaner'
  gem 'factory_bot'
  gem 'rack-test', require: 'rack/test'
  gem 'rspec'
  gem 'rubocop'
  gem 'simplecov', require: false
  gem 'sqlite3', '~> 1.3.6'
end

group :development do
  gem 'capistrano', '~> 3.11.0', require: false
  gem 'capistrano-bundler',      require: false
  gem 'capistrano-passenger',    require: false
  gem 'capistrano-pending',      require: false
  gem 'pry'
end
