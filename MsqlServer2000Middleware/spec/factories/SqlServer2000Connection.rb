#Factory.define :SqlServer2000Connection do |f|
#  f.cache ["amount", "15"]
#end
FactoryGirl.define do
  factory :SqlServer2000Connection do
    qty_fuel "8.7"
    meter_1 "380797"
    ftk_date "2012/01/05 13:19:00 -0500"
    row_id "30672"
    X_datetime_insert "2012/01/05 13:19:49 -0500"
    EQ_equip_no "3201"
  end
end