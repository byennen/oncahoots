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

ActiveRecord::Schema.define(:version => 20130911013716) do

  create_table "club_events", :force => true do |t|
    t.integer  "club_id"
    t.string   "title"
    t.string   "time"
    t.string   "date"
    t.string   "location"
    t.string   "description"
    t.string   "category"
    t.string   "image"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "club_photos", :force => true do |t|
    t.integer  "club_id"
    t.string   "image"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "clubs", :force => true do |t|
    t.string   "name"
    t.string   "category"
    t.text     "description"
    t.integer  "university_id"
    t.integer  "user_id"
    t.string   "slug"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "image"
    t.boolean  "private"
    t.text     "mission_statement"
  end

  create_table "experiences", :force => true do |t|
    t.string   "position_name"
    t.string   "company_name"
    t.date     "date_started"
    t.date     "date_ended"
    t.integer  "profile_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "invitations", :force => true do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.integer  "club_id"
    t.string   "token"
    t.datetime "sent_at"
    t.string   "new"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "locations", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "memberships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "club_id"
    t.boolean  "admin"
    t.boolean  "manager"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "invitation_id"
  end

  create_table "portfolio_items", :force => true do |t|
    t.string   "file"
    t.integer  "profile_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "profiles", :force => true do |t|
    t.integer  "user_id"
    t.text     "skills"
    t.string   "education"
    t.text     "experience"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "image"
  end

  create_table "records", :force => true do |t|
    t.integer  "club_id"
    t.string   "file"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "statuses", :force => true do |t|
    t.integer  "club_id"
    t.integer  "user_id"
    t.string   "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "universities", :force => true do |t|
    t.string   "name"
    t.string   "mascot"
    t.string   "location"
    t.string   "slug"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "image"
  end

  create_table "updates", :force => true do |t|
    t.text     "body"
    t.integer  "updateable_id"
    t.string   "updateable_type"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "image"
    t.string   "headline"
  end

  add_index "updates", ["updateable_id", "updateable_type"], :name => "index_updates_on_updateable_id_and_updateable_type"

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
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "university_id"
    t.integer  "location_id"
    t.string   "graduation_year"
    t.string   "major"
    t.string   "double_major"
    t.string   "slug"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

end
