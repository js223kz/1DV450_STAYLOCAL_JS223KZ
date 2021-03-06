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

ActiveRecord::Schema.define(version: 20160411083014) do

  create_table "api_v1_birds", force: :cascade do |t|
    t.string   "bird_name"
    t.string   "latin_name"
    t.string   "regularity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "api_v1_birds_spots", id: false, force: :cascade do |t|
    t.integer "bird_id"
    t.integer "spot_id"
  end

  add_index "api_v1_birds_spots", ["bird_id", "spot_id"], name: "index_api_v1_birds_spots_on_bird_id_and_spot_id"

  create_table "api_v1_birdspotters", force: :cascade do |t|
    t.string   "user_name",       limit: 30
    t.string   "email",           limit: 70
    t.string   "password_digest"
    t.string   "user_token"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "api_v1_spots", force: :cascade do |t|
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "birdspotter_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "api_v1_spots", ["birdspotter_id"], name: "index_api_v1_spots_on_birdspotter_id"

  create_table "apikeys", force: :cascade do |t|
    t.string   "application_name"
    t.string   "application_key"
    t.integer  "user_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "apikeys", ["user_id"], name: "index_apikeys_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "username",        limit: 70
    t.string   "password_digest"
    t.boolean  "admin",                      default: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

end
