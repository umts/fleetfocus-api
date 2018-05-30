# frozen_string_literal: true
FactoryBot.define do
  sequence :row_id

  factory :fueling do
    qty_fuel 0.0
    meter_1 0
    ftk_date 1.day.ago
    row_id
    add_attribute(:X_datetime_insert, 1.day.ago)
    add_attribute(:EQ_equip_no, '3201')
  end
end
