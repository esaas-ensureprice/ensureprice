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

ActiveRecord::Schema.define(version: 20221029015034) do

  create_table "doctors", force: :cascade do |t|
    t.string "insurance_plan"
    t.string "doctor_name"
    t.string "state"
    t.text   "zip_code"
    t.text   "speciality"
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

end
