# frozen_string_literal: true

require 'application_record'

class Fueling < ApplicationRecord
  self.table_name_prefix = 'emsdba.' unless ENV['RACK_ENV'] == 'test'
  self.table_name = 'FTK_MAIN'
  self.primary_key = 'row_id'

  def readonly?
    ENV['RACK_ENV'] == 'test' ? super : true
  end
end
