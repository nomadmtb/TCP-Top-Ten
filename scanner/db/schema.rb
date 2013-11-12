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

ActiveRecord::Schema.define(version: 20131110230027) do

  create_table "comments", force: true do |t|
    t.integer  "scan_id"
    t.integer  "user_id"
    t.datetime "comment_date"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["scan_id"], name: "index_comments_on_scan_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "open_ports", force: true do |t|
    t.integer  "scan_id"
    t.integer  "port"
    t.string   "service"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "open_ports", ["scan_id"], name: "index_open_ports_on_scan_id"

  create_table "scans", force: true do |t|
    t.integer  "user_id"
    t.datetime "scan_date"
    t.string   "ip_address"
    t.string   "status"
    t.string   "elapsed"
    t.string   "domain_name_ptr"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "scans", ["user_id"], name: "index_scans_on_user_id"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
