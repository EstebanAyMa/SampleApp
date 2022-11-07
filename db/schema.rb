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

ActiveRecord::Schema[7.0].define(version: 2022_11_06_200000) do
  create_table "addresses", force: :cascade do |t|
    t.integer "user_id"
    t.string "line_1"
    t.string "line_2"
    t.string "line_3"
    t.string "town"
    t.string "county"
    t.string "postcode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "bag_items", force: :cascade do |t|
    t.integer "shopping_bag_id"
    t.integer "cruise_id"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cruise_id"], name: "index_bag_items_on_cruise_id"
    t.index ["shopping_bag_id"], name: "index_bag_items_on_shopping_bag_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cruises", force: :cascade do |t|
    t.integer "region_id"
    t.integer "destination_id"
    t.string "name"
    t.text "description"
    t.decimal "price"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "primary_img"
    t.string "other_imgs"
    t.index ["destination_id"], name: "index_cruises_on_destination_id"
    t.index ["region_id"], name: "index_cruises_on_region_id"
  end

  create_table "destinations", force: :cascade do |t|
    t.string "name"
    t.integer "region_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["region_id"], name: "index_destinations_on_region_id"
  end

  create_table "regions", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reservation_items", force: :cascade do |t|
    t.integer "order_id"
    t.integer "cruise_id"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cruise_id"], name: "index_reservation_items_on_cruise_id"
    t.index ["order_id"], name: "index_reservation_items_on_order_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.integer "user_id"
    t.decimal "item_total"
    t.decimal "postage"
    t.integer "status", default: 0
    t.integer "shipping_address_id"
    t.integer "billing_address_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["billing_address_id"], name: "index_reservations_on_billing_address_id"
    t.index ["shipping_address_id"], name: "index_reservations_on_shipping_address_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "shopping_bags", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_shopping_bags_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin"
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
