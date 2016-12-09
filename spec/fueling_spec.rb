# frozen_string_literal: true
require 'fueling'

RSpec.describe Fueling do
  it 'uses row_id as its primary key' do
    fueling = create :fueling
    expect(fueling.row_id).to eq(fueling.id)
  end

  it 'reverse-sorts by fuel date by default' do
    f1 = create :fueling, ftk_date: 1.day.ago
    f2 = create :fueling, ftk_date: 3.days.ago
    f3 = create :fueling, ftk_date: 4.days.ago
    f4 = create :fueling, ftk_date: 2.days.ago
    expect(Fueling.pluck(:row_id)).to eq([f1, f4, f2, f3].map(&:id))
  end

  it 'uses the AS aliases specified' do
    create :fueling
    with_scope = Fueling.last
    without_scope = Fueling.unscoped.last

    expect(with_scope.attributes.keys).to contain_exactly('row_id',
                                                          'EQ_equip_no',
                                                          'amount',
                                                          'mileage',
                                                          'time_at',
                                                          'fuel_focus_row_id',
                                                          'time_at_insertion')

    expect(with_scope.amount).to eq(without_scope.qty_fuel)
    expect(with_scope.mileage).to eq(without_scope.meter_1)
    expect(with_scope.fuel_focus_row_id).to eq(without_scope.row_id)
    # I think this is a limitation of sqlite?
    # The result of "SELECT some_time AS other" returns a `String` in test
    # only.  There are other differences too, but they # don't break `#==`
    expect(DateTime.parse(with_scope.time_at)).to eq(without_scope.ftk_date)
    expect(DateTime.parse(with_scope.time_at_insertion))
      .to eq(without_scope.X_datetime_insert)
  end
end
