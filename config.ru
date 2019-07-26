# frozen_string_literal: true

require 'yaml'
require 'json'
require 'bundler'

$LOAD_PATH.unshift File.join(__dir__, 'lib')

env = ENV['RACK_ENV']
Bundler.require(:default, env)

require 'fueling'
require 'eam_app'

run EAMApp
