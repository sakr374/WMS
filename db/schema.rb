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

ActiveRecord::Schema[8.0].define(version: 2026_03_28_203220) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "api_keys", force: :cascade do |t|
    t.string "token", null: false
    t.string "name", null: false
    t.boolean "active", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["token"], name: "index_api_keys_on_token", unique: true
  end

  create_table "fulfillments", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.string "fulfillment_status"
    t.string "primary_tracking"
    t.string "primary_tracking_company"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_fulfillments_on_order_id"
  end

  create_table "inventories", force: :cascade do |t|
    t.string "sku", null: false
    t.string "name", null: false
    t.string "upc"
    t.string "uom_base", default: "EA", null: false
    t.boolean "is_active", default: true, null: false
    t.boolean "is_kit", default: false, null: false
    t.boolean "is_batch", default: false, null: false
    t.boolean "is_serial", default: false, null: false
    t.boolean "is_hazard", default: false, null: false
    t.decimal "cost", precision: 10, scale: 2, default: "0.0"
    t.string "currency", default: "USD"
    t.string "category"
    t.string "storage"
    t.string "coo"
    t.string "hs_code"
    t.decimal "uom_base_length", precision: 8, scale: 2
    t.decimal "uom_base_width", precision: 8, scale: 2
    t.decimal "uom_base_height", precision: 8, scale: 2
    t.decimal "uom_base_weight", precision: 8, scale: 2
    t.string "warehouse_code"
    t.string "warehouse_name"
    t.integer "customer_id"
    t.string "account"
    t.string "ringfence_tag"
    t.string "location"
    t.string "lp_number"
    t.datetime "lp_creation_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["is_active"], name: "index_inventories_on_is_active"
    t.index ["is_kit"], name: "index_inventories_on_is_kit"
    t.index ["sku"], name: "index_inventories_on_sku", unique: true
  end

  create_table "license_plates", force: :cascade do |t|
    t.bigint "inventory_id", null: false
    t.string "batch_number"
    t.date "expiration"
    t.integer "stock"
    t.integer "reserved"
    t.integer "available"
    t.string "tag"
    t.string "location_path"
    t.string "license_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["inventory_id"], name: "index_license_plates_on_inventory_id"
  end

  create_table "order_lines", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.bigint "inventory_id", null: false
    t.string "sku"
    t.string "uom"
    t.integer "planned"
    t.integer "completed"
    t.string "lot_control"
    t.date "expiration"
    t.string "ringfence_tag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["inventory_id"], name: "index_order_lines_on_inventory_id"
    t.index ["order_id"], name: "index_order_lines_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "reference"
    t.string "order_number"
    t.string "order_type", null: false
    t.string "order_status", null: false
    t.date "date_1"
    t.integer "lines_count", default: 0, null: false
    t.string "delivery_type"
    t.integer "carrier_id"
    t.string "tracking"
    t.text "instruction"
    t.integer "warehouse_id"
    t.integer "customer_id"
    t.jsonb "shipping_address", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_orders_on_created_at"
    t.index ["order_status"], name: "index_orders_on_order_status"
    t.index ["order_type"], name: "index_orders_on_order_type"
  end

  create_table "stocks", force: :cascade do |t|
    t.bigint "inventory_id", null: false
    t.integer "stock", default: 0, null: false
    t.integer "reserved", default: 0, null: false
    t.integer "available", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["available"], name: "index_stocks_on_available"
    t.index ["inventory_id"], name: "index_stocks_on_inventory_id"
  end

  add_foreign_key "fulfillments", "orders"
  add_foreign_key "license_plates", "inventories"
  add_foreign_key "order_lines", "inventories"
  add_foreign_key "order_lines", "orders"
  add_foreign_key "stocks", "inventories"
end
