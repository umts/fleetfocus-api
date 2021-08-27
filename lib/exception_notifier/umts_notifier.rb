# frozen_string_literal: true

module ExceptionNotifier
  class UmtsNotifier < EmailNotifier
    def initialize(options)
      @env = options.fetch(:env)
      super({
        email_prefix: 'umts/fleetfocus-api exception: ',
        sender_address: %("Fleetfocus-api" <transit-it@admin.umass.edu>),
        exception_recipients: %w[transit-it@admin.umass.edu],
        smtp_settings: {
          address: 'mailhub.oit.umass.edu',
          port: 25
        }
      })
    end

    def call(exception, options = {})
      super if @env == 'production'
    end
  end
end
