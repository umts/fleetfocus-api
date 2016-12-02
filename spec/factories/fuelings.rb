FactoryGirl.define do
  sequence :row_id

  factory :fueling do
    qty_fuel
    meter_1
    ftk_date
    row_id
    add_attribute(:X_datetime_insert)
    add_attribute(:EQ_equip_no)
  end
end
