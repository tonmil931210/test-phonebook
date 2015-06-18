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

ActiveRecord::Schema.define(version: 3) do

  create_table "agendas", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "agendas", ["user_id"], name: "index_agendas_on_user_id"

  create_table "contacts", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "last_name"
    t.string   "phone"
    t.string   "cellphone"
    t.string   "address"
    t.integer  "agenda_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "contacts", ["agenda_id"], name: "index_contacts_on_agenda_id"

  create_table "users", force: :cascade do |t|
    t.string   "username",                        null: false
    t.string   "password_digest",                 null: false
    t.string   "token"
    t.boolean  "sa",              default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "users", ["password_digest"], name: "index_users_on_password_digest"
  add_index "users", ["token"], name: "index_users_on_token"
  add_index "users", ["username"], name: "index_users_on_username", unique: true

end
