# frozen_string_literal: true

source 'https://rubygems.org'
ruby file: '.ruby-version'

gem 'activesupport', require: 'active_support/all'
gem 'exception_notification'
gem 'irb'
gem 'json'
gem 'psych'
gem 'puma'
gem 'rails', '~> 8.0.3', install_if: false
gem 'rake'
gem 'sinatra', require: 'sinatra/base'
gem 'sinatra-activerecord', require: false
gem 'tilt-jbuilder', require: 'sinatra/jbuilder'

group :production, :development do
  gem 'activerecord-sqlserver-adapter'
  gem 'tiny_tds', force_ruby_platform: true # TODO: Remove dependency completely when have newer GLIBC.
end

group :test do
  gem 'database_cleaner'
  gem 'factory_bot'
  gem 'rack-test', require: 'rack/test'
  gem 'rspec'
  gem 'simplecov', require: false
  gem 'sqlite3', '>= 2.1'
end

group :development do
  gem 'bcrypt_pbkdf', '>= 1.0', '< 2.0', require: false
  gem 'capistrano', '~> 3.19', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-passenger', require: false
  gem 'capistrano-pending', require: false
  gem 'ed25519', '>= 1.2', '< 2.0', require: false
  gem 'railties', require: false
  gem 'rubocop', require: false
  gem 'rubocop-factory_bot', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rake', require: false
  gem 'rubocop-rspec', require: false
end
