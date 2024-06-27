# frozen_string_literal: true

json.connection_valid true
json.error ''
json.fueling @fuelings do |fueling|
  json.EQ_equip_no fueling.EQ_equip_no
  json.amount fueling.qty_fuel.to_f
  json.fuel_focus_row_id fueling.row_id
  json.mileage fueling.meter_1
  json.time_at fueling.ftk_date
  json.time_at_insertion fueling.X_datetime_insert
end
