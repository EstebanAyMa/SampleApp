class CreateModels < ActiveRecord::Migration[7.0]
  def change

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

    create_table "categories", force: :cascade do |t|
      t.string "name"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    create_table "contacts", force: :cascade do |t|
      t.string "name"
      t.string "email"
      t.string "message"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    create_table "order_items", force: :cascade do |t|
      t.integer "order_id"
      t.integer "cruise_id"
      t.integer "quantity"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["order_id"], name: "index_order_items_on_order_id"
      t.index ["cruise_id"], name: "index_order_items_on_cruise_id"
    end

    create_table "orders", force: :cascade do |t|
      t.integer "user_id"
      t.decimal "item_total"
      t.decimal "postage"
      t.integer "status", default: 0
      t.integer "shipping_address_id"
      t.integer "billing_address_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["billing_address_id"], name: "index_orders_on_billing_address_id"
      t.index ["shipping_address_id"], name: "index_orders_on_shipping_address_id"
      t.index ["user_id"], name: "index_orders_on_user_id"
    end

    create_table "cruises", force: :cascade do |t|
      t.integer "category_id"
      t.integer "sub_category_id"
      t.string "name"
      t.text "description"
      t.decimal "price"
      t.integer "quantity"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "primary_img"
      t.string "other_imgs"
      t.index ["category_id"], name: "index_products_on_category_id"
      t.index ["sub_category_id"], name: "index_products_on_sub_category_id"
    end

    create_table "shopping_bags", force: :cascade do |t|
      t.integer "user_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["user_id"], name: "index_shopping_bags_on_user_id"
    end

    create_table "sub_categories", force: :cascade do |t|
      t.string "name"
      t.integer "category_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["category_id"], name: "index_sub_categories_on_category_id"
    end
  end
end

