# frozen_string_literal: true

class CreateFuelingsAgain < ActiveRecord::Migration
  def up
    return if table_exists? 'FTK_MAIN'

    # note that this is a partial table compared to what's in the EAM DB,
    # but it contains all of the columns we actually use in this application.
    create_table 'FTK_MAIN', primary_key: 'row_id' do |t|
      t.decimal  'qty_fuel'
      t.integer  'meter_1'
      t.datetime 'ftk_date'
      t.datetime 'X_datetime_insert'
      t.string   'EQ_equip_no'
    end
  end

  def down
    return if ActiveRecord.version < Gem::Version.new('5.0')

    drop_table 'FTK_MAIN'
  end
end
