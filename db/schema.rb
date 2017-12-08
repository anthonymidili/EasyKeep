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

ActiveRecord::Schema.define(version: 20171208014421) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "address_1", limit: 255
    t.string "address_2", limit: 255
    t.string "city", limit: 255
    t.string "state", limit: 255
    t.string "zip", limit: 255
    t.string "phone", limit: 255
    t.string "fax", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "company_id"
    t.integer "user_id"
    t.boolean "uses_account_name", default: true
    t.boolean "uses_contact_name", default: true
    t.string "prefix"
    t.string "postfix"
    t.string "divider"
    t.index ["company_id", "name"], name: "index_accounts_on_company_id_and_name", unique: true
    t.index ["company_id"], name: "index_accounts_on_company_id"
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "companies", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "address_1", limit: 255
    t.string "address_2", limit: 255
    t.string "city", limit: 255
    t.string "state", limit: 255
    t.string "zip", limit: 255
    t.string "phone", limit: 255
    t.string "fax", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "established_on"
    t.string "license_number", limit: 255
    t.string "service_provided", limit: 255
    t.text "service_summery"
    t.string "logo", limit: 255
    t.string "website", limit: 255
    t.decimal "sales_tax", precision: 7, scale: 4, default: "0.0"
  end

  create_table "inventory_items", id: :serial, force: :cascade do |t|
    t.string "description", limit: 255
    t.string "serial_number", limit: 255
    t.integer "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "quantity", precision: 19, scale: 3
    t.index ["company_id"], name: "index_inventory_items_on_company_id"
  end

  create_table "invoices", id: :serial, force: :cascade do |t|
    t.integer "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "established_at"
    t.integer "company_id"
    t.decimal "sales_tax", precision: 7, scale: 4
    t.integer "number"
    t.index ["account_id"], name: "index_invoices_on_account_id"
    t.index ["company_id", "number"], name: "index_invoices_on_company_id_and_number", unique: true
    t.index ["company_id"], name: "index_invoices_on_company_id"
  end

  create_table "payments", id: :serial, force: :cascade do |t|
    t.string "transaction_type", limit: 255
    t.date "received_on"
    t.decimal "amount", precision: 19, scale: 2
    t.integer "invoice_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "memo"
    t.integer "account_id"
    t.integer "company_id"
    t.index ["account_id"], name: "index_payments_on_account_id"
    t.index ["company_id"], name: "index_payments_on_company_id"
    t.index ["invoice_id"], name: "index_payments_on_invoice_id"
  end

  create_table "services", id: :serial, force: :cascade do |t|
    t.date "performed_on"
    t.decimal "cost", precision: 19, scale: 2
    t.text "memo"
    t.integer "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "invoice_id"
    t.integer "company_id"
    t.index ["account_id"], name: "index_services_on_account_id"
    t.index ["company_id"], name: "index_services_on_company_id"
    t.index ["invoice_id"], name: "index_services_on_invoice_id"
  end

  create_table "taggings", id: :serial, force: :cascade do |t|
    t.integer "tag_id"
    t.integer "inventory_item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["inventory_item_id"], name: "index_taggings_on_inventory_item_id"
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.integer "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_tags_on_company_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", limit: 255
    t.string "encrypted_password", limit: 255, default: ""
    t.string "reset_password_token", limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip", limit: 255
    t.string "last_sign_in_ip", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "company_id"
    t.string "invitation_token"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.integer "invited_by_id"
    t.string "invited_by_type", limit: 255
    t.string "name", limit: 255
    t.boolean "is_admin", default: false
    t.datetime "invitation_created_at"
    t.boolean "is_owner", default: false
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
