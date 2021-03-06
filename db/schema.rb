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

ActiveRecord::Schema.define(version: 20150813001359) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "add_product_inventories", force: true do |t|
    t.integer "product_id",                   null: false
    t.integer "bill_provider_id",             null: false
    t.integer "amount",           default: 1, null: false
  end

  add_index "add_product_inventories", ["bill_provider_id"], name: "index_add_product_inventories_on_bill_provider_id", using: :btree
  add_index "add_product_inventories", ["product_id"], name: "index_add_product_inventories_on_product_id", using: :btree

  create_table "bill_articles", force: true do |t|
    t.integer "bill_id",              null: false
    t.integer "amount",   default: 1, null: false
    t.integer "price_id",             null: false
  end

  add_index "bill_articles", ["bill_id"], name: "index_bill_articles_on_bill_id", using: :btree
  add_index "bill_articles", ["price_id"], name: "index_bill_articles_on_price_id", using: :btree

  create_table "bill_providers", force: true do |t|
    t.string   "number"
    t.float    "price"
    t.integer  "provider_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bill_providers", ["provider_id"], name: "index_bill_providers_on_provider_id", using: :btree

  create_table "bills", force: true do |t|
    t.integer  "client_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bills", ["client_id"], name: "index_bills_on_client_id", using: :btree

  create_table "cash_transactions", force: true do |t|
    t.string   "type_t",      limit: 10, default: "deposit", null: false
    t.text     "description",                                null: false
    t.float    "amount",                 default: 0.0,       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clients", force: true do |t|
    t.string  "dni",                                      null: false
    t.string  "name",                                     null: false
    t.date    "subscription_date", default: '2015-05-27', null: false
    t.float   "balance",           default: 0.0,          null: false
    t.boolean "active",            default: true
  end

  add_index "clients", ["dni"], name: "index_clients_on_dni", unique: true, using: :btree

  create_table "combo_products", force: true do |t|
    t.integer "product_id",                 null: false
    t.integer "combo_id",                   null: false
    t.integer "product_amount", default: 1, null: false
  end

  add_index "combo_products", ["combo_id"], name: "index_combo_products_on_combo_id", using: :btree
  add_index "combo_products", ["product_id"], name: "index_combo_products_on_product_id", using: :btree

  create_table "combos", force: true do |t|
    t.string   "name",                              null: false
    t.integer  "sales_amount",       default: 0,    null: false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.boolean  "active",             default: true
  end

  add_index "combos", ["name"], name: "index_combos_on_name", unique: true, using: :btree

  create_table "prices", force: true do |t|
    t.string   "type_option", limit: 2, default: "p", null: false
    t.float    "value",                 default: 1.0, null: false
    t.integer  "product_id"
    t.integer  "combo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "prices", ["combo_id"], name: "index_prices_on_combo_id", using: :btree
  add_index "prices", ["product_id"], name: "index_prices_on_product_id", using: :btree

  create_table "product_providers", force: true do |t|
    t.integer "product_id",  null: false
    t.integer "provider_id", null: false
  end

  add_index "product_providers", ["product_id"], name: "index_product_providers_on_product_id", using: :btree
  add_index "product_providers", ["provider_id"], name: "index_product_providers_on_provider_id", using: :btree

  create_table "product_tags", force: true do |t|
    t.integer "product_id", null: false
    t.integer "tag_id",     null: false
  end

  add_index "product_tags", ["product_id"], name: "index_product_tags_on_product_id", using: :btree
  add_index "product_tags", ["tag_id"], name: "index_product_tags_on_tag_id", using: :btree

  create_table "products", force: true do |t|
    t.string   "name",                              null: false
    t.integer  "stock_amount",       default: 0,    null: false
    t.integer  "sales_amount",       default: 0,    null: false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.boolean  "active",             default: true
  end

  add_index "products", ["name"], name: "index_products_on_name", unique: true, using: :btree

  create_table "products_withdraws", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "providers", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "providers", ["name"], name: "index_providers_on_name", unique: true, using: :btree

  create_table "remove_product_inventories", force: true do |t|
    t.integer "product_id",                      null: false
    t.integer "product_withdraw_id",             null: false
    t.integer "amount",              default: 1, null: false
  end

  add_index "remove_product_inventories", ["product_id"], name: "index_remove_product_inventories_on_product_id", using: :btree
  add_index "remove_product_inventories", ["product_withdraw_id"], name: "index_remove_product_inventories_on_product_withdraw_id", using: :btree

  create_table "sale_transactions", force: true do |t|
    t.string  "type_t",  limit: 10, default: "cash", null: false
    t.float   "amount",             default: 0.0,    null: false
    t.integer "bill_id"
  end

  add_index "sale_transactions", ["bill_id"], name: "index_sale_transactions_on_bill_id", using: :btree

  create_table "tags", force: true do |t|
    t.string "name", null: false
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                  default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
