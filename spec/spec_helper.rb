require 'rubygems'
require 'bundler'
Bundler.require(:default, :test)
require File.join(File.dirname(__FILE__), '..', 'app.rb')

Dir[File.dirname(__FILE__)+"/factories/*.rb"].each {|file| require file }

# set test environment
class FuelFocusApp
  set :environment, :test
  set :run, false
  set :raise_errors, true
  set :logging, false
end
