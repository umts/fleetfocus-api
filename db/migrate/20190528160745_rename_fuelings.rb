# frozen_string_literal: true

class RenameFuelings < ActiveRecord::Migration[4.2]
  def change
    return if ActiveRecord.version >= Gem::Version.new('5.0')

    rename_table 'emsdba.FTK_MAIN', 'FTK_MAIN'
  end
end
