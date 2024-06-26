# frozen_string_literal: true

ActiveRecord.default_timezone = :local

class Fueling < ActiveRecord::Base
  # :nocov:
  self.table_name_prefix = 'emsdba.' unless ENV['RACK_ENV'] == 'test'
  # :nocov:
  self.table_name = 'FTK_MAIN'
  self.primary_key = 'row_id'
end
