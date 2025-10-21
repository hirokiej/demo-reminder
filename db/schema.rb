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

ActiveRecord::Schema[8.0].define(version: 2025_10_21_075741) do
  create_table "add_line_acceccto_users", force: :cascade do |t|
    t.integer "line_channel_id"
    t.string "channel_secret"
    t.string "channel_access_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "friends", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "line_user_id"
    t.string "line_display_name"
    t.string "real_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_friends_on_user_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "title"
    t.datetime "start_time"
    t.datetime "end_time"
    t.text "description"
    t.string "google_event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_schedules_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "line_channel_id"
    t.string "line_channel_secret"
    t.string "line_channel_access_token"
    t.string "google_token"
    t.string "google_refresh_token"
  end

  add_foreign_key "friends", "users"
  add_foreign_key "schedules", "users"
end
