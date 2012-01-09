require File.join(File.dirname(__FILE__), '..', 'app.rb')
require 'rubygems'
require 'sinatra'
require 'rack/test'
require 'spec'
require 'spec/autorun'
require 'spec/interop/test'
require 'json'
require 'date'
require 'factory_girl'

Dir[File.dirname(__FILE__)+"/factories/*.rb"].each {|file| require file }

# set test environment
set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false