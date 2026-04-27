# frozen_string_literal: true

source 'https://rubygems.org'
ruby file: '.ruby-version'

gem 'activesupport', require: 'active_support/all'
gem 'exception_notification'
gem 'irb'
gem 'json'
gem 'psych'
gem 'puma'
gem 'rails', '~> 8.1.1', install_if: false
gem 'rake'
gem 'sinatra', require: 'sinatra/base'
gem 'sinatra-activerecord', require: false
gem 'tilt-jbuilder', require: 'sinatra/jbuilder'

group :production, :development do
  gem 'activerecord-sqlserver-adapter'
  gem 'tiny_tds'
end

group :development do
  gem 'kamal', require: false
  gem 'railties', require: false
  gem 'rubocop', require: false
  gem 'rubocop-factory_bot', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rake', require: false
  gem 'rubocop-rspec', require: false
end

group :test do
  gem 'database_cleaner'
  gem 'factory_bot'
  gem 'rack-test', require: 'rack/test'
  gem 'rspec'
  gem 'simplecov', require: false
  gem 'sqlite3', '>= 2.1'
end
