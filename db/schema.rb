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

ActiveRecord::Schema.define(version: 20160207182003) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chips", force: :cascade do |t|
    t.string   "name"
    t.integer  "price"
    t.string   "description"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "concert_orders", force: :cascade do |t|
    t.integer  "concert_id"
    t.integer  "order_id"
    t.integer  "quantity"
    t.float    "subtotal"
    t.float    "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "concert_orders", ["concert_id"], name: "index_concert_orders_on_concert_id", using: :btree
  add_index "concert_orders", ["order_id"], name: "index_concert_orders_on_order_id", using: :btree

  create_table "concerts", force: :cascade do |t|
    t.date     "date"
    t.string   "band"
    t.integer  "price"
    t.integer  "venue_id"
    t.string   "genre"
    t.string   "url"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
  end

  add_index "concerts", ["venue_id"], name: "index_concerts_on_venue_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.string   "status"
    t.float    "total_price"
    t.integer  "user_id"
    t.string   "address"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password_digest"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "role",            default: 0
    t.string   "picture"
  end

  create_table "venues", force: :cascade do |t|
    t.string  "name"
    t.integer "status",      default: 0
    t.string  "image"
    t.string  "city"
    t.string  "state"
    t.string  "address"
    t.string  "description"
    t.string  "url"
    t.integer "user_id"
  end

  add_index "venues", ["user_id"], name: "index_venues_on_user_id", using: :btree

  add_foreign_key "concert_orders", "concerts"
  add_foreign_key "concert_orders", "orders"
  add_foreign_key "concerts", "venues"
  add_foreign_key "orders", "users"
  add_foreign_key "venues", "users"
end
