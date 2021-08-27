# frozen_string_literal: true

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

    def access_log!
      log_path('access').open('a+').tap { |log| log.sync = true }
    end

    def error_log!
      log_path('error').open('a+').tap { |log| log.sync = true }
    end

    def log_path(type)
      Pathname(__dir__).expand_path.join('../log', "#{@env}_#{type}.log")
    end
  end
end
