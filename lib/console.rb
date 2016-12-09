# frozen_string_literal: true
require 'yaml'
require 'json'
require 'bundler'

this_dir = File.dirname(__FILE__)

env = ENV['RACK_ENV'] || 'development'
Bundler.require(:default, env)

config_file = File.join(this_dir, '..', 'config', 'database.yml')
db_config = YAML.load_file(config_file)[env]
ActiveRecord::Base.establish_connection(db_config)

require 'fueling'
require 'eam_app'
