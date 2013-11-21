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

ActiveRecord::Schema.define(:version => 20131121033354) do

  create_table "alert_user_notifications", :force => true do |t|
    t.integer  "alert_id"
    t.integer  "user_id"
    t.boolean  "unread",     :default => true
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "alerts", :force => true do |t|
    t.integer  "alertable_id"
    t.string   "alertable_type"
    t.string   "message"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "cities", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "image"
  end

  create_table "club_photos", :force => true do |t|
    t.integer  "club_id"
    t.string   "image"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
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
    t.integer  "city_id"
    t.string   "type"
  end

  create_table "comments", :force => true do |t|
    t.string   "comment"
    t.integer  "user_id"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "contact_requirements", :force => true do |t|
    t.integer  "profile_id"
    t.string   "gpa_requirement"
    t.string   "major_requirement"
    t.string   "years_working_experience"
    t.string   "fields_of_interest"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  create_table "conversations", :force => true do |t|
    t.string   "subject",    :default => ""
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "customers", :force => true do |t|
    t.integer  "club_id"
    t.integer  "user_id"
    t.string   "stripe_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "customers", ["club_id"], :name => "index_customers_on_club_id"
  add_index "customers", ["user_id"], :name => "index_customers_on_user_id"

  create_table "educations", :force => true do |t|
    t.integer  "profile_id"
    t.string   "completed"
    t.string   "major"
    t.string   "university"
    t.string   "degree_type"
    t.string   "graduation_year"
    t.string   "high_school"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "events", :force => true do |t|
    t.integer  "club_id"
    t.string   "title"
    t.string   "time"
    t.string   "date"
    t.string   "location"
    t.text     "description"
    t.string   "category"
    t.string   "image"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.boolean  "free_food"
    t.integer  "eventable_id"
    t.string   "eventable_type"
    t.date     "on_date"
    t.time     "at_time"
    t.boolean  "display_on_uc"
    t.integer  "user_id"
    t.integer  "university_id"
  end

  create_table "experiences", :force => true do |t|
    t.string   "position_name"
    t.string   "company_name"
    t.date     "date_started"
    t.date     "date_ended"
    t.integer  "profile_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.boolean  "present"
  end

  create_table "faqs", :force => true do |t|
    t.integer  "profile_id"
    t.text     "question"
    t.text     "answer"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "interesteds", :force => true do |t|
    t.integer  "user_id"
    t.integer  "interested_obj_id"
    t.string   "interested_obj_type"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "interesteds", ["user_id"], :name => "index_interesteds_on_user_id"

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

  create_table "items", :force => true do |t|
    t.integer  "club_id"
    t.string   "name"
    t.text     "description"
    t.string   "status"
    t.decimal  "price",       :precision => 8, :scale => 2
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  add_index "items", ["club_id"], :name => "index_items_on_club_id"

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
    t.string   "title"
  end

  create_table "notifications", :force => true do |t|
    t.string   "type"
    t.text     "body"
    t.string   "subject",              :default => ""
    t.integer  "sender_id"
    t.string   "sender_type"
    t.integer  "conversation_id"
    t.boolean  "draft",                :default => false
    t.datetime "updated_at",                              :null => false
    t.datetime "created_at",                              :null => false
    t.integer  "notified_object_id"
    t.string   "notified_object_type"
    t.string   "notification_code"
    t.string   "attachment"
    t.boolean  "global",               :default => false
    t.datetime "expires"
  end

  add_index "notifications", ["conversation_id"], :name => "index_notifications_on_conversation_id"

  create_table "options", :force => true do |t|
    t.integer  "item_id"
    t.string   "name"
    t.string   "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "options", ["item_id"], :name => "index_options_on_item_id"

  create_table "portfolio_items", :force => true do |t|
    t.string   "file"
    t.integer  "profile_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "name"
    t.string   "organization_name"
    t.string   "image"
    t.text     "description"
  end

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "club_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "posts", ["club_id"], :name => "index_posts_on_club_id"
  add_index "posts", ["user_id"], :name => "index_posts_on_user_id"

  create_table "professional_fields", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "profiles", :force => true do |t|
    t.integer  "user_id"
    t.text     "skills"
    t.string   "education"
    t.text     "experience"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "image"
    t.string   "view_profile"
    t.string   "hometown"
    t.string   "skill1"
    t.string   "skill2"
    t.string   "skill3"
  end

  create_table "receipts", :force => true do |t|
    t.integer  "receiver_id"
    t.string   "receiver_type"
    t.integer  "notification_id",                                  :null => false
    t.boolean  "is_read",                       :default => false
    t.boolean  "trashed",                       :default => false
    t.boolean  "deleted",                       :default => false
    t.string   "mailbox_type",    :limit => 25
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
  end

  add_index "receipts", ["notification_id"], :name => "index_receipts_on_notification_id"

  create_table "records", :force => true do |t|
    t.integer  "club_id"
    t.string   "file"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "relationships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "relation_id"
    t.text     "message"
    t.string   "status"
    t.datetime "accepted_at"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "recommended_by_id"
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

  create_table "stripe_credentials", :force => true do |t|
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "stripe_publishable_key"
    t.string   "token"
    t.string   "uid"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  create_table "universities", :force => true do |t|
    t.string   "name"
    t.string   "mascot"
    t.string   "location"
    t.string   "slug"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "image"
    t.string   "banner"
  end

  create_table "updates", :force => true do |t|
    t.text     "body"
    t.integer  "updateable_id"
    t.string   "updateable_type"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "image"
    t.string   "headline"
    t.integer  "user_id"
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
    t.string   "city"
    t.string   "state"
    t.boolean  "alumni"
    t.integer  "professional_field_id"
    t.integer  "city_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

  add_foreign_key "notifications", "conversations", name: "notifications_on_conversation_id"

  add_foreign_key "receipts", "notifications", name: "receipts_on_notification_id"

end
