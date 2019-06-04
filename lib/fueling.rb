# frozen_string_literal: true

class Fueling < ActiveRecord::Base
  self.table_name_prefix = 'emsdba.' unless ENV['RACK_ENV'] == 'test'
  self.table_name = 'FTK_MAIN'
  self.primary_key = 'row_id'
  self.default_timezone = :local

  default_scope do
    order('ftk_date DESC').select 'qty_fuel AS amount',
                                  'meter_1 AS mileage',
                                  'ftk_date AS time_at',
                                  'row_id AS fuel_focus_row_id',
                                  'X_datetime_insert AS time_at_insertion',
                                  'EQ_equip_no'
  end

  def inspect
    "#<#{self.class} #{attributes.slice('EQ_equip_no', 'amount', 'time_at')}>"
  end

  def readonly?
    ENV['RACK_ENV'] == 'test' ? super : true
  end
end
