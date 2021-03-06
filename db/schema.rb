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

ActiveRecord::Schema.define(version: 20170927032155) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "time"
    t.integer "duration_minutes", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "location_id"
    t.string "slug"
    t.index ["duration_minutes"], name: "index_events_on_duration_minutes"
    t.index ["location_id"], name: "index_events_on_location_id"
    t.index ["name"], name: "index_events_on_name"
    t.index ["time"], name: "index_events_on_time"
  end

  create_table "events_users", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.bigint "user_id", null: false
    t.index ["event_id", "user_id"], name: "index_events_users_on_event_id_and_user_id", unique: true
    t.index ["event_id"], name: "index_events_users_on_event_id"
    t.index ["user_id"], name: "index_events_users_on_user_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name", null: false
    t.string "address", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address"], name: "index_locations_on_address", unique: true
    t.index ["name"], name: "index_locations_on_name", unique: true
  end

  create_table "preferences", force: :cascade do |t|
    t.bigint "timeslot_id", null: false
    t.bigint "user_id", null: false
    t.integer "preference_type", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["timeslot_id"], name: "index_preferences_on_timeslot_id"
    t.index ["user_id"], name: "index_preferences_on_user_id"
  end

  create_table "timeslots", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.datetime "start_time", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_timeslots_on_event_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email"
    t.index ["name"], name: "index_users_on_name"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "events", "locations"
  add_foreign_key "events_users", "events"
  add_foreign_key "events_users", "users"
  add_foreign_key "preferences", "timeslots"
  add_foreign_key "timeslots", "events"
end
