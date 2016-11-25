source 'https://rubygems.org'

gem 'sinatra',             require: "sinatra/base"
gem 'activerecord-sqlserver-adapter', '~> 4.2.0'
gem 'tiny_tds'

group :test do
  gem 'rspec'
  gem 'rack-test',         require: "rack/test"
  gem 'factory_girl'
end

group :development do
  gem 'capistrano', '=3.4.0', require: false
  gem 'capistrano-pending',   require: false
  gem 'capistrano-bundler',   require: false
  gem 'capistrano-passenger', require: false
  gem 'pry'
end
