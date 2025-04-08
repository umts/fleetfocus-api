# frozen_string_literal: true

require_relative 'config/environment'

# development and production use an unmodifiable db
if ENV.fetch('RACK_ENV', 'development') == 'test'
  require 'sinatra/activerecord'
  require 'sinatra/activerecord/rake'
end
