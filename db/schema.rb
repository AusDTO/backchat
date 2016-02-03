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

ActiveRecord::Schema.define(version: 20160202034021) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pgcrypto"

  create_table "forms", id: :uuid, default: "gen_random_uuid()", force: :cascade do |t|
    t.string "website"
    t.jsonb  "input_fields"
  end

  create_table "global_configs", force: :cascade do |t|
    t.string   "app_name"
    t.string   "app_domain"
    t.string   "facebook_app_id"
    t.string   "twitter_app_id"
    t.string   "linkedin_app_id"
    t.boolean  "use_slack",       default: false
    t.string   "slack_team"
    t.string   "slack_icon_url"
    t.string   "slack_user"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "identities", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "identities", ["user_id"], name: "index_identities_on_user_id", using: :btree

  create_table "output_jobs", id: false, force: :cascade do |t|
    t.integer  "output_id",     null: false
    t.integer  "submission_id", null: false
    t.boolean  "success"
    t.jsonb    "result"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "outputs", id: :uuid, default: "gen_random_uuid()", force: :cascade do |t|
    t.jsonb  "configuration"
    t.string "type"
    t.uuid   "form_id"
  end

  add_index "outputs", ["form_id"], name: "index_outputs_on_form_id", using: :btree

  create_table "submissions", id: :uuid, default: "gen_random_uuid()", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "path"
    t.decimal  "satisfaction", precision: 3
    t.binary   "file"
    t.string   "file_type"
    t.jsonb    "content"
    t.uuid     "form_id"
  end

  add_index "submissions", ["form_id"], name: "index_submissions_on_form_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "name"
    t.boolean  "admin",                  default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "outputs", "forms"
end
