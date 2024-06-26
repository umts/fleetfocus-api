# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2019_05_28_161310) do
  create_table "FTK_MAIN", primary_key: "row_id", force: :cascade do |t|
    t.decimal "qty_fuel"
    t.integer "meter_1"
    t.datetime "ftk_date", precision: nil
    t.datetime "X_datetime_insert", precision: nil
    t.string "EQ_equip_no"
  end

end
