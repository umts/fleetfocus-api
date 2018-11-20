# frozen_string_literal: true

require 'yaml'
require 'json'
require 'bundler'

env = ENV['RACK_ENV'] || 'development'
Bundler.require(:default, env)

require 'fueling'
require 'eam_app'
