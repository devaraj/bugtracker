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

ActiveRecord::Schema.define(:version => 20120714190132) do

  create_table "buglabelassignments", :force => true do |t|
    t.integer  "bug_id"
    t.integer  "label_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "bugs", :force => true do |t|
    t.string  "bugtitle"
    t.text    "bugdescription"
    t.string  "fileuploadpath"
    t.integer "assignedto_user_id"
    t.integer "assignedby_user_id"
    t.integer "project_id"
    t.date    "created_at",         :null => false
    t.string  "created_by"
    t.date    "updated_at",         :null => false
    t.string  "updated_by"
    t.string  "status"
  end

  add_index "bugs", ["assignedby_user_id"], :name => "index_bugs_on_assignedby_user_id"
  add_index "bugs", ["assignedto_user_id"], :name => "index_bugs_on_assignedto_user_id"
  add_index "bugs", ["project_id"], :name => "index_bugs_on_project_id"

  create_table "comments", :force => true do |t|
    t.string  "content"
    t.integer "user_id"
    t.integer "bug_id"
    t.date    "created_at", :null => false
    t.date    "updated_at", :null => false
    t.string  "created_by"
    t.string  "updated_by"
    t.string  "status"
    t.string  "bugstatus"
  end

  add_index "comments", ["bug_id"], :name => "index_comments_on_bug_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "labels", :force => true do |t|
    t.string  "labelname"
    t.string  "status"
    t.date    "created_at", :null => false
    t.string  "created_by"
    t.date    "updated_at", :null => false
    t.string  "updated_by"
    t.string  "labelcolor"
    t.integer "project_id"
  end

  create_table "projects", :force => true do |t|
    t.string "projectname"
    t.text   "projectdescription"
    t.date   "projectstartdate"
    t.date   "projectenddate"
    t.string "status"
    t.date   "created_at",         :null => false
    t.string "created_by"
    t.date   "updated_at",         :null => false
    t.string "updated_by"
  end

  create_table "roles", :force => true do |t|
    t.string "rolename"
    t.date   "created_at", :null => false
    t.string "created_by"
    t.date   "updated_at", :null => false
    t.string "updated_by"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "user_assignments", :force => true do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string  "username"
    t.string  "password"
    t.string  "email"
    t.date    "created_at", :null => false
    t.string  "created_by"
    t.date    "updated_at", :null => false
    t.string  "updated_by"
    t.integer "role_id"
  end

  add_index "users", ["role_id"], :name => "index_users_on_role_id"

end
