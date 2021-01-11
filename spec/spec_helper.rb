# frozen_string_literal: true

require 'simplecov'
SimpleCov.start do
  load_profile 'test_frameworks'

  add_filter %r{^/config/}
  add_filter %r{^/db/}
  add_filter 'lib/console.rb'

  track_files 'lib/**/*.rb'
end

ENV['RACK_ENV'] = 'test'

require 'bundler'
Bundler.require(:default, :test)

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

module RSpecMixin
  include Rack::Test::Methods
  def app
    described_class
  end
end

RSpec.configure do |config|
  config.disable_monkey_patching!
  config.warnings = true

  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  config.order = :random
  Kernel.srand config.seed

  config.default_formatter = 'doc' if config.files_to_run.one?

  config.include RSpecMixin

  config.include FactoryBot::Syntax::Methods
  config.before(:suite) do
    FactoryBot.find_definitions
  end

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with :truncation
  end

  config.around do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
