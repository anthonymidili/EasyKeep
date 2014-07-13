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

ActiveRecord::Schema.define(version: 20140711220536) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: true do |t|
    t.string   "name"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.string   "fax"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "company_id"
    t.integer  "user_id"
    t.boolean  "uses_account_name", default: true
    t.boolean  "uses_contact_name", default: true
  end

  create_table "companies", force: true do |t|
    t.string   "name"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.string   "fax"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.date     "established_on"
    t.string   "license_number"
    t.string   "service_provided"
    t.text     "service_summery"
    t.string   "logo"
    t.string   "website"
  end

  create_table "inventory_items", force: true do |t|
    t.string   "description"
    t.string   "serial_number"
    t.integer  "company_id"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.decimal  "quantity",      precision: 19, scale: 3
  end

  create_table "invoices", force: true do |t|
    t.integer  "account_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.date     "established_at"
    t.integer  "company_id"
    t.integer  "sales_tax",      default: 7
  end

  create_table "payments", force: true do |t|
    t.string   "transaction_type"
    t.date     "received_on"
    t.decimal  "amount",           precision: 19, scale: 2
    t.integer  "invoice_id"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.text     "memo"
    t.integer  "account_id"
    t.integer  "company_id"
  end

  create_table "services", force: true do |t|
    t.date     "performed_on"
    t.decimal  "cost",         precision: 19, scale: 2
    t.text     "memo"
    t.integer  "account_id"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "invoice_id"
    t.integer  "company_id"
  end

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "inventory_item_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "taggings", ["inventory_item_id"], name: "index_taggings_on_inventory_item_id", using: :btree
  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree

  create_table "tags", force: true do |t|
    t.string   "name"
    t.integer  "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "encrypted_password",     default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "company_id"
    t.string   "invitation_token"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.string   "name"
    t.boolean  "is_admin",               default: false
    t.datetime "invitation_created_at"
    t.boolean  "is_owner",               default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
