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

ActiveRecord::Schema.define(version: 20150714161024) do

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "communities", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inkwell_blog_items", force: :cascade do |t|
    t.integer  "blogged_item_id"
    t.string   "blogged_item_type"
    t.integer  "blogging_owner_id"
    t.string   "blogging_owner_type"
    t.datetime "created_at",          null: false
  end

  add_index "inkwell_blog_items", ["blogged_item_id", "blogged_item_type"], name: "index_blog_items_on_item"
  add_index "inkwell_blog_items", ["blogging_owner_id", "blogging_owner_type"], name: "index_blog_items_on_owner"

  create_table "inkwell_communities_users", force: :cascade do |t|
    t.integer  "community_user_id"
    t.string   "community_user_type"
    t.integer  "community_id"
    t.string   "community_type"
    t.integer  "user_access"
    t.integer  "admin_level"
    t.boolean  "muted",               default: false
    t.boolean  "active",              default: false
    t.boolean  "banned",              default: false
    t.boolean  "asked_invitation",    default: false
    t.datetime "created_at",                          null: false
  end

  add_index "inkwell_communities_users", ["community_id", "community_type"], name: "index_community_user_on_community"
  add_index "inkwell_communities_users", ["community_user_id", "community_user_type"], name: "index_community_user_on_user"

  create_table "inkwell_favorited_items", force: :cascade do |t|
    t.integer  "favorited_id"
    t.string   "favorited_type"
    t.integer  "favoriting_id"
    t.string   "favoriting_type"
    t.datetime "created_at",      null: false
  end

  add_index "inkwell_favorited_items", ["favorited_id", "favorited_type"], name: "index_favorited_items_on_item"
  add_index "inkwell_favorited_items", ["favoriting_id", "favoriting_type"], name: "index_favorited_items_on_user"

  create_table "posts", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: :cascade do |t|
    t.integer  "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "nick"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
