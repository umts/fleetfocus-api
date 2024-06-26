# frozen_string_literal: true

require 'yaml'
require 'json'
require 'bundler'

$LOAD_PATH.unshift File.join(__dir__, 'lib')

env = ENV.fetch 'RACK_ENV', 'development'
Bundler.require(:default, env)

require 'eam_app'

run EAMApp
