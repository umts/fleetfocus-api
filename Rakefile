# frozen_string_literal: true
require 'bundler'
env = ENV['RACK_ENV'] || 'development'
Bundler.require(:default, env)

this_dir = File.dirname(__FILE__)
$LOAD_PATH.unshift File.join(this_dir, 'lib')

# development and production use an unmodifiable db
if env == 'test'
  require 'sinatra/activerecord/rake'

  namespace :db do
    task :load_config do
      require 'eam_app'
    end
  end
end
