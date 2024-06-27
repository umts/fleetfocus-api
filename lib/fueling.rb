# frozen_string_literal: true

require 'application_record'

class Fueling < ApplicationRecord
  self.table_name = 'FTK_MAIN'
  self.primary_key = 'row_id'

  def readonly?
    ENV.fetch('RACK_ENV', nil) == 'test' ? super : true
  end
end
