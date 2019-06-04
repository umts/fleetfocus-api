# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20190528161310) do

  create_table "FTK_MAIN", primary_key: "row_id", force: :cascade do |t|
    t.decimal  "qty_fuel"
    t.integer  "meter_1"
    t.datetime "ftk_date"
    t.datetime "X_datetime_insert"
    t.string   "EQ_equip_no"
  end

end
