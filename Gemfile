source 'https://rubygems.org'

gem 'sinatra',             :require => "sinatra/base"
gem 'thin',                :require => false
gem 'activerecord-sqlserver-adapter', '~> 4.2.0'
gem 'tiny_tds'
gem 'hashie'

group :test do
  gem 'rspec', "=1.3.2",   :require => "spec"
  gem 'rack-test',         :require => "rack/test"
  gem 'factory_girl'
end

group :development do
  gem 'capistrano', require: false
  gem 'capistrano-pending', require: false
  gem 'capistrano-bundler', require: false
  gem 'pry'
end
