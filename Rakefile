# frozen_string_literal: true

require 'bundler'
env = ENV['RACK_ENV'] || 'development'
Bundler.require(:default, env)

$LOAD_PATH.unshift File.join(__dir__, 'lib')

# development and production use an unmodifiable db
if env == 'test'
  require 'sinatra/activerecord/rake'

  namespace :db do
    task :load_config do
      require 'eam_app'
    end
  end
end
