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

ActiveRecord::Schema.define(:version => 20101007192708) do

  create_table "catalogs", :force => true do |t|
    t.string   "title"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.text     "body"
    t.boolean  "reports_problem"
    t.integer  "user_id"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "data_record_locations", :force => true do |t|
    t.integer  "data_record_id"
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "data_records", :force => true do |t|
    t.string   "title"
    t.string   "slug"
    t.string   "homepage_url"
    t.text     "description"
    t.string   "project_name"
    t.string   "funder"
    t.string   "year"
    t.integer  "owner_id"
    t.integer  "catalog_id"
    t.integer  "contact_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ratings_count", :default => 0
    t.integer  "ratings_total", :default => 0
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "documents", :force => true do |t|
    t.integer  "data_record_id"
    t.string   "external_url"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "document_type"
    t.string   "title"
  end

  create_table "favorites", :force => true do |t|
    t.integer  "user_id"
    t.integer  "data_record_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", :force => true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "data_record_id"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "open_id_authentication_associations", :force => true do |t|
    t.integer "issued"
    t.integer "lifetime"
    t.string  "handle"
    t.string  "assoc_type"
    t.binary  "server_url"
    t.binary  "secret"
  end

  create_table "open_id_authentication_nonces", :force => true do |t|
    t.integer "timestamp",  :null => false
    t.string  "server_url"
    t.string  "salt",       :null => false
  end

  create_table "organizations", :force => true do |t|
    t.string   "name"
    t.string   "acronym"
    t.string   "org_type"
    t.text     "description"
    t.string   "slug"
    t.string   "url"
    t.string   "homepage_url"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "location_id"
  end

  create_table "people", :force => true do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "email"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "affiliation_id"
    t.integer  "data_record_id"
  end

  create_table "ratings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "data_record_id"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sponsors", :force => true do |t|
    t.integer  "data_record_id"
    t.integer  "organization_id"
    t.boolean  "lead"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "submissions", :force => true do |t|
    t.string   "type"
    t.string   "name"
    t.string   "email"
    t.integer  "user_id"
    t.string   "title"
    t.string   "url"
    t.text     "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
  end

  add_index "submissions", ["type"], :name => "index_submissions_on_type"
  add_index "submissions", ["user_id"], :name => "index_submissions_on_user_id"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "taggable_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.string   "single_access_token"
    t.string   "perishable_token"
    t.integer  "login_count",         :default => 0
    t.integer  "failed_login_count",  :default => 0
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "confirmed_at"
    t.string   "openid_identifier"
    t.string   "display_name"
    t.string   "api_id"
    t.boolean  "list_opt_in",         :default => false
    t.string   "city"
    t.string   "personal_url"
    t.string   "telephone_number"
    t.string   "user_type"
    t.string   "role"
    t.datetime "updated_at"
    t.datetime "created_at"
    t.integer  "affiliation_id"
    t.integer  "location_id"
  end

  create_table "votes", :force => true do |t|
    t.boolean  "vote",          :default => true
    t.integer  "voteable_id"
    t.string   "voteable_type"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["user_id"], :name => "index_votes_on_user_id"

  create_table "wiki_versions", :force => true do |t|
    t.integer  "wiki_id"
    t.integer  "version"
    t.integer  "data_record_id"
    t.integer  "user_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "wiki_versions", ["wiki_id"], :name => "index_wiki_versions_on_wiki_id"

  create_table "wikis", :force => true do |t|
    t.integer  "data_record_id"
    t.integer  "user_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "version"
  end

end
