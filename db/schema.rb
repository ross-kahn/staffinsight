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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130719170707) do

  create_table "equipment", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "name"
    t.integer  "status_id"
    t.integer  "profile_id"
  end

  create_table "equipment_events", :id => false, :force => true do |t|
    t.integer "equipment_id", :null => false
    t.integer "event_id",     :null => false
  end

  add_index "equipment_events", ["equipment_id", "event_id"], :name => "index_equipment_events_on_equipment_id_and_event_id"

  create_table "equipment_profiles", :id => false, :force => true do |t|
    t.integer "equipment_id", :null => false
    t.integer "profile_id",   :null => false
  end

  add_index "equipment_profiles", ["equipment_id", "profile_id"], :name => "index_equipment_profiles_on_equipment_id_and_profile_id"

  create_table "events", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "name"
    t.string   "location"
    t.datetime "time"
  end

  create_table "events_profiles", :id => false, :force => true do |t|
    t.integer "event_id",   :null => false
    t.integer "profile_id", :null => false
  end

  add_index "events_profiles", ["event_id", "profile_id"], :name => "index_events_profiles_on_event_id_and_profile_id"

  create_table "events_skills", :id => false, :force => true do |t|
    t.integer "event_id", :null => false
    t.integer "skill_id", :null => false
  end

  create_table "profiles", :force => true do |t|
    t.string   "title"
    t.integer  "rank_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "profiles_skills", :id => false, :force => true do |t|
    t.integer "profile_id", :null => false
    t.integer "skill_id",   :null => false
  end

  add_index "profiles_skills", ["profile_id", "skill_id"], :name => "index_profiles_skills_on_profile_id_and_skill_id"

  create_table "ranks", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "skills", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "statuses", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name",                   :default => "", :null => false
    t.string   "role"
    t.integer  "profile_id"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
