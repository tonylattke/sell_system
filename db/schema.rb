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

ActiveRecord::Schema.define(version: 20150531123234) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: true do |t|
    t.string "dni",                                      null: false
    t.string "name",                                     null: false
    t.date   "subscription_date", default: '2015-05-27', null: false
    t.float  "balance",           default: 0.0,          null: false
  end

  add_index "clients", ["dni"], name: "index_clients_on_dni", unique: true, using: :btree

  create_table "products", force: true do |t|
    t.string   "name",                           null: false
    t.integer  "stock_amount",       default: 0, null: false
    t.integer  "sales_amount",       default: 0, null: false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  add_index "products", ["name"], name: "index_products_on_name", unique: true, using: :btree

  create_table "providers", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "providers", ["name"], name: "index_providers_on_name", unique: true, using: :btree

  create_table "tags", force: true do |t|
    t.string "name", null: false
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

end
