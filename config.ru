require 'yaml'
require 'json'
require 'bundler'

this_dir = File.dirname(__FILE__)
$LOAD_PATH.unshift File.join(this_dir, 'lib')

env = ENV['RACK_ENV']
Bundler.require(:default, env)

require 'fueling'
require 'eam_app'

run EAMApp
