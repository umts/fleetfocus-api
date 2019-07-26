# frozen_string_literal: true

class Fueling < ActiveRecord::Base
  self.table_name_prefix = 'emsdba.' unless ENV['RACK_ENV'] == 'test'
  self.table_name = 'FTK_MAIN'
  self.primary_key = 'row_id'
  self.default_timezone = :local

  def readonly?
    ENV['RACK_ENV'] == 'test' ? super : true
  end
end
