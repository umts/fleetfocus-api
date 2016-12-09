# frozen_string_literal: true
ENV['RACK_ENV'] = 'test'

require 'bundler'
Bundler.require(:default, :test)

$LOAD_PATH.unshift File.expand_path '../../lib', __FILE__

module RSpecMixin
  include Rack::Test::Methods
  def app
    described_class
  end
end

RSpec.configure do |config|
  config.disable_monkey_patching!
  config.warnings = true
  config.order = :random
  config.default_formatter = 'doc' if config.files_to_run.one?

  config.include RSpecMixin

  config.include FactoryGirl::Syntax::Methods
  config.before(:suite) do
    FactoryGirl.find_definitions
  end

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with :truncation
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
