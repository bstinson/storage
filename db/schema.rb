# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20080805000423) do

  create_table "buildings", :force => true do |t|
    t.string   "name"
    t.integer  "company_id", :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notes", :force => true do |t|
    t.string   "note"
    t.integer  "unit_id",         :limit => 11
    t.integer  "user_id",         :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "prevcustomer_id", :limit => 11
  end

  create_table "prevcustomers", :force => true do |t|
    t.string   "name"
    t.string   "ssn"
    t.string   "dl"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.string   "email"
    t.string   "work_cell"
    t.string   "alt_contact"
    t.string   "alt_phone"
    t.string   "auth_users"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "units", :force => true do |t|
    t.integer  "unit_num",      :limit => 11
    t.integer  "width",         :limit => 11
    t.integer  "height",        :limit => 11
    t.decimal  "monthly_price",               :precision => 8, :scale => 2
    t.string   "name"
    t.string   "ssn"
    t.string   "dl"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.string   "email"
    t.string   "work_cell"
    t.string   "alt_contact"
    t.string   "alt_phone"
    t.string   "auth_users"
    t.string   "code"
    t.string   "status"
    t.integer  "building_id",   :limit => 11
    t.integer  "company_id",    :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "deposit",                     :precision => 8, :scale => 2, :default => 0.0
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password"
    t.integer  "company_id", :limit => 11, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
