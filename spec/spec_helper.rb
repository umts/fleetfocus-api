require 'bundler'
Bundler.require(:default, :test)

ENV['RACK_ENV'] = 'test'

require File.expand_path '../../eam.rb', __FILE__

module RSpecMixin
  include Rack::Test::Methods
  def app() described_class end
end

RSpec.configure do |config|
  config.include RSpecMixin

  config.include FactoryGirl::Syntax::Methods
  config.before(:suite) do
    FactoryGirl.find_definitions
  end
end
