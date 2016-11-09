require 'yaml'
require 'net/ssh/gateway'
require 'json'
require 'bundler'

Bundler.require

require './eam'
run EAMApp
