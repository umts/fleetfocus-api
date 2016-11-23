require 'bundler'
Bundler.require(:default, :test)

ENV['RACK_ENV'] = 'test'

require File.expand_path '../../eam.rb', __FILE__

FactoryGirl.definition_file_paths = %w{./factories ./test/factories ./spec/factories}
FactoryGirl.find_definitions

module RSpecMixin
  include Rack::Test::Methods
  def app() described_class end
end

RSpec.configure { |c| c.include RSpecMixin }
