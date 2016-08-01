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

ActiveRecord::Schema.define(version: 20160731150204) do

  create_table "lines", force: :cascade do |t|
    t.string   "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lines_turns", id: false, force: :cascade do |t|
    t.integer "line_id"
    t.integer "turn_id"
  end

  add_index "lines_turns", ["line_id", "turn_id"], name: "index_lines_turns_on_line_id_and_turn_id"

  create_table "turns", force: :cascade do |t|
    t.string   "name"
    t.string   "time_on",     limit: 4
    t.string   "time_off",    limit: 4
    t.time     "duration"
    t.string   "hours"
    t.time     "start_time"
    t.time     "finish_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
