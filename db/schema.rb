ActiveRecord::Schema.define(version: 20160202223028) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chip_orders", force: :cascade do |t|
    t.integer "chip_id"
    t.integer "order_id"
    t.integer "quantity"
    t.float   "subtotal"
  end

  add_index "chip_orders", ["chip_id"], name: "index_chip_orders_on_chip_id", using: :btree
  add_index "chip_orders", ["order_id"], name: "index_chip_orders_on_order_id", using: :btree

  create_table "chips", force: :cascade do |t|
    t.string   "name"
    t.float    "price"
    t.string   "description"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.integer  "oil_id"
    t.string   "slug"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "status",             default: "Available"
  end

  add_index "chips", ["oil_id"], name: "index_chips_on_oil_id", using: :btree

  create_table "oils", force: :cascade do |t|
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.string   "status",      default: "Ordered"
    t.float    "total_price"
    t.integer  "user_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "address"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password_digest"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "role",            default: 0
  end

  create_table "venues_tables", force: :cascade do |t|
    t.string "name"
    t.string "status"
    t.string "background_image"
    t.string "city"
    t.string "state"
    t.string "address"
  end

  add_foreign_key "chip_orders", "chips"
  add_foreign_key "chip_orders", "orders"
  add_foreign_key "chips", "oils"
end
