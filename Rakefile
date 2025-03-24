# frozen_string_literal: true

require 'bundler'
env = ENV['RACK_ENV'] || 'development'
Bundler.require(:default, env)

$LOAD_PATH.unshift File.join(__dir__, 'lib')

# development and production use an unmodifiable db
if env == 'test'
  require 'sinatra/activerecord'
  require 'sinatra/activerecord/rake'
end

desc 'Check that we can connect to the database'
task :check do
  require 'sinatra/activerecord'
  require 'application_record'
  ApplicationRecord.establish_connection(env.to_sym)
  ApplicationRecord.connection.execute('SELECT 1')

  puts 'Database connection successful'
end
