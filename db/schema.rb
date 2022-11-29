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

ActiveRecord::Schema.define(version: 20221129194522) do

  create_table "doctor_reviews", force: :cascade do |t|
    t.integer  "doctor_id"
    t.string   "doctor_name"
    t.string   "user_email"
    t.string   "user_name"
    t.text     "review_title"
    t.text     "user_review"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "rating",       default: 1, null: false
  end

  create_table "doctors", force: :cascade do |t|
    t.string  "last_name"
    t.string  "first_name"
    t.text    "national_provider_identifier"
    t.text    "medicaid_provider"
    t.string  "site_name"
    t.string  "room_or_suite"
    t.string  "street_address"
    t.string  "town_city"
    t.string  "state"
    t.string  "county"
    t.string  "zip_code"
    t.text    "phone_number"
    t.string  "provider_type"
    t.string  "gender"
    t.string  "commercial_provider_indicator"
    t.text    "plan_name"
    t.string  "insurance_plan"
    t.string  "specialty"
    t.string  "designation"
    t.string  "doctor_name"
    t.text    "location"
    t.integer "rating"
  end

  create_table "insurance_plans", force: :cascade do |t|
    t.string "company_name"
    t.text   "insurance_plan_name"
    t.text   "individual_annual_deductible"
    t.text   "ov"
    t.text   "er"
    t.text   "uc"
    t.text   "spc"
    t.text   "ho"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
