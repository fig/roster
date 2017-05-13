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

ActiveRecord::Schema.define(version: 20170513003358) do

  create_table "base_rosters", force: :cascade do |t|
    t.string   "name"
    t.string   "version"
    t.string   "depot"
    t.string   "link"
    t.integer  "duration"
    t.date     "commencement_date"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "lines_count",       default: 0
    t.string   "suffix"
  end

  create_table "days", force: :cascade do |t|
    t.string   "name"
    t.integer  "line_id"
    t.integer  "turn_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "days", ["line_id"], name: "index_days_on_line_id"
  add_index "days", ["turn_id"], name: "index_days_on_turn_id"

  create_table "lines", force: :cascade do |t|
    t.integer  "number"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "base_roster_id"
    t.string   "sun",            default: "OFF"
    t.string   "mon",            default: "RD"
    t.string   "tue",            default: "RD"
    t.string   "wed",            default: "RD"
    t.string   "thu",            default: "RD"
    t.string   "fri",            default: "RD"
    t.string   "sat",            default: "RD"
  end

  add_index "lines", ["base_roster_id"], name: "index_lines_on_base_roster_id"

  create_table "profiles", force: :cascade do |t|
    t.string   "name_first",   default: ""
    t.string   "name_last",    default: ""
    t.date     "roster_epoch"
    t.integer  "user_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id"

  create_table "turns", force: :cascade do |t|
    t.string   "name"
    t.string   "time_on",        limit: 4, default: ""
    t.string   "time_off",       limit: 4, default: ""
    t.time     "duration"
    t.string   "hours"
    t.time     "start_time"
    t.time     "finish_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "start_date"
    t.date     "end_date"
    t.boolean  "sun"
    t.boolean  "mon"
    t.boolean  "tue"
    t.boolean  "wed"
    t.boolean  "thu"
    t.boolean  "fri"
    t.boolean  "sat"
    t.integer  "base_roster_id"
    t.string   "shift"
  end

  add_index "turns", ["base_roster_id"], name: "index_turns_on_base_roster_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "base_roster_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "token"
  end

  add_index "users", ["base_roster_id"], name: "index_users_on_base_roster_id"
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
