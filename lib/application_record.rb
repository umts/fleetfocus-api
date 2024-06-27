# frozen_string_literal: true

ActiveRecord.default_timezone = :local

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  # :nocov:
  self.table_name_prefix = 'emsdba.' unless ENV['RACK_ENV'] == 'test'
  # :nocov:
end
