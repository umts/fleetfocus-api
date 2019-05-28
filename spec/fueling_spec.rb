# frozen_string_literal: true

require 'fueling'

RSpec.describe Fueling do
  it 'uses row_id as its primary key' do
    fueling = create :fueling
    expect(fueling.row_id).to eq(fueling.id)
  end

  it 'reverse-sorts by fuel date by default' do
    sorted_fuelings = [(create :fueling, ftk_date: 1.day.ago),
                       (create :fueling, ftk_date: 3.days.ago),
                       (create :fueling, ftk_date: 4.days.ago),
                       (create :fueling, ftk_date: 2.days.ago)]
                      .sort { |a, b| b.ftk_date <=> a.ftk_date }

    expect(Fueling.pluck(:row_id)).to eq(sorted_fuelings.map(&:id))
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
    ta_parsed = Time.parse(
      "#{with_scope.time_at} #{Time.now.zone}"
    )
    tai_parsed = Time.parse(
      "#{with_scope.time_at_insertion} #{Time.now.zone}"
    )
    expect(ta_parsed).to eq(without_scope.ftk_date)
    expect(tai_parsed).to eq(without_scope.X_datetime_insert)
  end

  describe '#inspect' do
    let :fueling do
      create :fueling,
             EQ_equip_no: '3333',
             qty_fuel: 12.3,
             ftk_date: Time.new(2000, 1, 1)
    end
    let :call do
      fueling.inspect
    end

    it 'contains the class name and key attributes' do
      expect(call).to match(/^#<Fueling/)
      expect(call).to match(/\{.*?vehicle.*?"3333"/)
      expect(call).to match(/\{.*?amount.*?12\.3/)
      expect(call).to match(/\{.*?time_at.*?2000-01-01 00:/)
    end
  end
end
