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

ActiveRecord::Schema.define(:version => 20100805102327) do

  create_table "dig_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dig_types_digs", :id => false, :force => true do |t|
    t.integer "dig_id"
    t.integer "dig_type_id"
  end

  add_index "dig_types_digs", ["dig_type_id"], :name => "index_dig_types_digs_on_dig_type_id"

  create_table "digs", :force => true do |t|
    t.string   "name"
    t.integer  "sleeps",                 :default => 0
    t.integer  "number_of_twin_rooms",   :default => 0
    t.integer  "number_of_double_rooms", :default => 0
    t.integer  "number_of_single_rooms", :default => 0
    t.integer  "number_of_sofa_beds",    :default => 0
    t.text     "landlords_notes"
    t.string   "address_1"
    t.string   "address_2"
    t.string   "address_3"
    t.string   "postcode"
    t.string   "landline"
    t.string   "mobile"
    t.string   "fax"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "dig_type_id"
    t.integer  "price_per_week_from",    :default => 0,                            :null => false
    t.string   "hash_code"
    t.string   "privacy",                :default => "theatre professionals only"
    t.integer  "price_per_night"
    t.string   "building"
    t.string   "price_per_week"
    t.boolean  "member",                 :default => false
    t.boolean  "published",              :default => true
  end

  add_index "digs", ["hash_code"], :name => "index_digs_on_hash_code"

  create_table "images", :force => true do |t|
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "dig_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invalid_dig_messages", :force => true do |t|
    t.integer  "dig_id"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "theatre_distances", :force => true do |t|
    t.integer  "dig_id"
    t.integer  "theatre_id"
    t.float    "distance"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "theatre_distances", ["dig_id"], :name => "index_theatre_distances_on_dig_id"

  create_table "theatres", :force => true do |t|
    t.string   "name"
    t.string   "postcode"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tours", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "code"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
