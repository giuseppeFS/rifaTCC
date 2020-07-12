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

ActiveRecord::Schema.define(version: 20191101004904) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account_entries", force: :cascade do |t|
    t.integer "wallet_id"
    t.float "value"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "admins", force: :cascade do |t|
    t.string "email"
    t.string "encrypted_password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.boolean "capital"
    t.integer "state_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "institutions", force: :cascade do |t|
    t.string "cnpj"
    t.string "email"
    t.string "encrypted_password"
    t.string "corporate_name"
    t.string "social_reason"
    t.string "address"
    t.string "number"
    t.string "complement"
    t.string "neighborhood"
    t.string "zipCode"
    t.string "ddd_phone"
    t.string "phone_number"
    t.string "ddd_phone2"
    t.string "phone_number2"
    t.integer "bank_number"
    t.integer "agency_number"
    t.integer "account_number"
    t.string "qualification"
    t.string "about"
    t.float "rating"
    t.boolean "status", default: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "raffles", force: :cascade do |t|
    t.integer "institution_id"
    t.integer "user_id"
    t.integer "category_id"
    t.string "delivery"
    t.string "condition"
    t.string "title"
    t.text "description"
    t.float "unit_value"
    t.float "goal_value"
    t.datetime "draw_date"
    t.string "prize"
    t.string "prize_description"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "regions", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "states", force: :cascade do |t|
    t.string "name"
    t.string "acronym"
    t.integer "region_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tickets", force: :cascade do |t|
    t.integer "raffle_id"
    t.integer "number"
    t.integer "owner_id"
    t.datetime "purchase_date"
    t.float "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "cpf"
    t.string "name"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "address"
    t.string "number"
    t.string "complement"
    t.string "neighborhood"
    t.string "zipCode"
    t.string "ddd_phone"
    t.string "phone_number"
    t.string "ddd_cellphone"
    t.string "cellphone_number"
    t.string "city_id"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wallets", force: :cascade do |t|
    t.integer "user_id"
    t.float "balance"
    t.float "blocked_balance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "zipcode_ranges", force: :cascade do |t|
    t.string "cep"
    t.string "name"
    t.string "acronym"
    t.string "neighborhood"
    t.string "address"
    t.string "number"
    t.string "complement"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
