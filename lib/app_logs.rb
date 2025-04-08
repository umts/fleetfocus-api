# frozen_string_literal: true

require 'fileutils'
require 'pathname'

module AppLogs
  class << self
    def registered(app)
      @env = app.settings.environment

      app.set :access_log, access_log!
      app.set :error_log, error_log!

      app.enable :logging
      app.use Rack::CommonLogger, app.settings.access_log

      app.before { env['rack.errors'] = app.settings.error_log }
    end

    private

    def access_log!
      FileUtils.mkdir_p log_dir
      log_path('access').open('a+').tap { |log| log.sync = true }
    end

    def error_log!
      FileUtils.mkdir_p log_dir
      log_path('error').open('a+').tap { |log| log.sync = true }
    end

    def log_path(type) = log_dir.join("#{@env}_#{type}.log")

    def log_dir = Pathname(__dir__).join('../log').expand_path
  end
end
