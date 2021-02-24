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

ActiveRecord::Schema.define(version: 2021_02_24_031216) do

  create_table "active_storage_attachments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "addresses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "type_of_address"
    t.string "status"
    t.string "entity"
    t.string "number_and_street"
    t.string "suite_or_apartment"
    t.string "city"
    t.integer "postal_code"
    t.string "country"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "building_details", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "information_key"
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "building_id"
    t.index ["building_id"], name: "index_building_details_on_building_id"
  end

  create_table "buildings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "full_name_of_the_building_administrator"
    t.string "email_of_the_administrator_of_the_building"
    t.integer "phone_number_of_the_building_administrator"
    t.string "full_name_of_the_technical_contact_for_the_building"
    t.string "echnical_contact_email_for_the_building"
    t.string "rechnical_contact_phone_for_the_building"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "addresses_id"
    t.bigint "customer_id"
    t.index ["addresses_id"], name: "index_buildings_on_addresses_id"
    t.index ["customer_id"], name: "index_buildings_on_customer_id"
  end

  create_table "customers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.date "customer_s_creation_date"
    t.string "company_name"
    t.string "full_name_of_the_company_contact"
    t.integer "company_contact_phone"
    t.string "email_of_the_company_contact"
    t.text "company_description"
    t.string "full_name_of_service_technical_authority"
    t.integer "technical_authority_phone_for_Service"
    t.string "technical_manager_email_for_service"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "addresses_id"
    t.bigint "user_id"
    t.index ["addresses_id"], name: "index_customers_on_addresses_id"
    t.index ["user_id"], name: "index_customers_on_user_id"
  end

  create_table "employees", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "title"
    t.string "email"
    t.bigint "user_id"
    t.index ["user_id"], name: "index_employees_on_user_id"
  end

  create_table "leads", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "full_name_of_the_contact"
    t.string "company_name"
    t.string "email"
    t.integer "phone"
    t.string "project_name"
    t.text "project_description"
    t.string "department_in_charge_of_the_elevators"
    t.text "message"
    t.binary "attached_file"
    t.date "date_of_the_contact"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "quotes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", limit: 100
    t.string "email", limit: 200
    t.string "phone", limit: 20
    t.string "bType"
    t.integer "numApart"
    t.integer "numFloor"
    t.integer "numBase"
    t.integer "numBusi"
    t.integer "numPark"
    t.integer "numCage"
    t.integer "occpFloor"
    t.integer "numHour"
    t.integer "numCorp"
    t.string "product"
    t.string "numElev"
    t.string "unitP"
    t.string "totalP"
    t.string "instalP"
    t.string "finalP"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "building_details", "buildings"
  add_foreign_key "buildings", "addresses", column: "addresses_id"
  add_foreign_key "buildings", "customers"
  add_foreign_key "customers", "addresses", column: "addresses_id"
  add_foreign_key "customers", "users"
  add_foreign_key "employees", "users"
end
