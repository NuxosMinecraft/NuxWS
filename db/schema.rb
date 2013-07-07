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

ActiveRecord::Schema.define(:version => 20130707074852) do

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "docs", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.text     "description"
    t.boolean  "modos_only"
    t.string   "slug"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "donations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "amount"
    t.boolean  "anonymous"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "forum_categories", :force => true do |t|
    t.string   "name"
    t.integer  "position"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "role"
  end

  create_table "forums", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "position"
    t.integer  "forum_category_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "role"
  end

  create_table "friendly_id_slugs", :force => true do |t|
    t.string   "slug",                         :null => false
    t.integer  "sluggable_id",                 :null => false
    t.string   "sluggable_type", :limit => 40
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type"], :name => "index_friendly_id_slugs_on_slug_and_sluggable_type", :unique => true
  add_index "friendly_id_slugs", ["sluggable_id"], :name => "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], :name => "index_friendly_id_slugs_on_sluggable_type"

  create_table "galleries", :force => true do |t|
    t.string   "title",       :null => false
    t.text     "description"
    t.integer  "place_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "slug"
  end

  create_table "images", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "picture"
    t.integer  "gallery_id"
    t.string   "slug"
  end

  create_table "logs", :force => true do |t|
    t.string   "category"
    t.string   "priority"
    t.text     "relations"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "message"
  end

  create_table "mailings", :force => true do |t|
    t.integer  "user_id"
    t.string   "subject"
    t.text     "message"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "roles"
  end

  create_table "messages", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.string   "username"
    t.integer  "edits",           :default => 0
    t.integer  "last_edit_by"
    t.string   "slug"
    t.integer  "topic_id"
    t.integer  "user_id"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.boolean  "deleted",         :default => false
    t.string   "deletion_reason"
    t.integer  "deletion_by"
  end

  create_table "places", :force => true do |t|
    t.integer  "user_id",           :null => false
    t.string   "name",              :null => false
    t.text     "short_description", :null => false
    t.text     "description"
    t.text     "history"
    t.text     "creators"
    t.text     "various"
    t.string   "slug"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "map_marker"
  end

  create_table "pms", :force => true do |t|
    t.integer  "user_id"
    t.integer  "to"
    t.string   "subject"
    t.text     "message"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.boolean  "read",       :default => false
  end

  create_table "read_marks", :force => true do |t|
    t.integer  "readable_id"
    t.integer  "user_id",                     :null => false
    t.string   "readable_type", :limit => 20, :null => false
    t.datetime "timestamp"
  end

  add_index "read_marks", ["user_id", "readable_type", "readable_id"], :name => "index_read_marks_on_user_id_and_readable_type_and_readable_id"

  create_table "roles", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "rid"
  end

  create_table "settings", :force => true do |t|
    t.string   "var",                       :null => false
    t.text     "value"
    t.integer  "target_id"
    t.string   "target_type", :limit => 30
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "settings", ["target_type", "target_id", "var"], :name => "index_settings_on_target_type_and_target_id_and_var", :unique => true

  create_table "topic_notifications", :force => true do |t|
    t.integer  "user_id"
    t.integer  "topic_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "topics", :force => true do |t|
    t.string   "title",                              :null => false
    t.text     "content",                            :null => false
    t.boolean  "moderation",      :default => false, :null => false
    t.boolean  "pin",             :default => false, :null => false
    t.boolean  "locked",          :default => false, :null => false
    t.integer  "forum_id"
    t.integer  "user_id"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "slug"
    t.string   "username"
    t.datetime "last_message_at"
  end

  add_index "topics", ["last_message_at"], :name => "index_topics_on_last_message_at"

  create_table "users", :force => true do |t|
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.string   "login",                               :null => false
    t.string   "crypted_password",                    :null => false
    t.string   "password_salt",                       :null => false
    t.string   "persistence_token",                   :null => false
    t.string   "perishable_token",    :default => "", :null => false
    t.string   "single_access_token"
    t.string   "email"
    t.integer  "login_count",         :default => 0,  :null => false
    t.datetime "last_request_at"
    t.datetime "last_login_at"
    t.datetime "current_login_at"
    t.string   "last_login_ip"
    t.string   "current_login_ip"
    t.string   "slug"
    t.integer  "role"
    t.text     "signature"
    t.string   "custom_role"
  end

  add_index "users", ["last_request_at"], :name => "index_users_on_last_request_at"
  add_index "users", ["login"], :name => "index_users_on_login"
  add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token"
  add_index "users", ["slug"], :name => "index_users_on_slug", :unique => true

end
