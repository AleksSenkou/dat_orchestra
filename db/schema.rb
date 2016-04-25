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

ActiveRecord::Schema.define(version: 20160425081359) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "base_page_translations", force: :cascade do |t|
    t.integer  "base_page_id", null: false
    t.string   "locale",       null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.text     "subheading"
  end

  add_index "base_page_translations", ["base_page_id"], name: "index_base_page_translations_on_base_page_id", using: :btree
  add_index "base_page_translations", ["locale"], name: "index_base_page_translations_on_locale", using: :btree

  create_table "base_pages", force: :cascade do |t|
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "favicon_file_name"
    t.string   "favicon_content_type"
    t.integer  "favicon_file_size"
    t.datetime "favicon_updated_at"
    t.string   "hero_image_file_name"
    t.string   "hero_image_content_type"
    t.integer  "hero_image_file_size"
    t.datetime "hero_image_updated_at"
    t.string   "heading"
    t.text     "subheading"
    t.string   "dance_logo_file_name"
    t.string   "dance_logo_content_type"
    t.integer  "dance_logo_file_size"
    t.datetime "dance_logo_updated_at"
    t.string   "bg_color"
  end

  create_table "composition_translations", force: :cascade do |t|
    t.integer  "composition_id", null: false
    t.string   "locale",         null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "title"
    t.text     "description"
  end

  add_index "composition_translations", ["composition_id"], name: "index_composition_translations_on_composition_id", using: :btree
  add_index "composition_translations", ["locale"], name: "index_composition_translations_on_locale", using: :btree

  create_table "compositions", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "position"
    t.string   "song_file_name"
    t.string   "song_content_type"
    t.integer  "song_file_size"
    t.datetime "song_updated_at"
  end

  create_table "compositions_members", id: false, force: :cascade do |t|
    t.integer "composition_id"
    t.integer "member_id"
  end

  add_index "compositions_members", ["composition_id"], name: "index_compositions_members_on_composition_id", using: :btree
  add_index "compositions_members", ["member_id"], name: "index_compositions_members_on_member_id", using: :btree

  create_table "contact_translations", force: :cascade do |t|
    t.integer  "contact_id", null: false
    t.string   "locale",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
  end

  add_index "contact_translations", ["contact_id"], name: "index_contact_translations_on_contact_id", using: :btree
  add_index "contact_translations", ["locale"], name: "index_contact_translations_on_locale", using: :btree

  create_table "contacts", force: :cascade do |t|
    t.string "email"
    t.string "phone_number"
    t.string "name"
    t.string "address"
  end

  create_table "gallery_item_translations", force: :cascade do |t|
    t.integer  "gallery_item_id", null: false
    t.string   "locale",          null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "title"
  end

  add_index "gallery_item_translations", ["gallery_item_id"], name: "index_gallery_item_translations_on_gallery_item_id", using: :btree
  add_index "gallery_item_translations", ["locale"], name: "index_gallery_item_translations_on_locale", using: :btree

  create_table "gallery_items", force: :cascade do |t|
    t.string   "title"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "position"
    t.string   "video_link"
  end

  create_table "instruments", force: :cascade do |t|
    t.string   "name"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "member_instruments", force: :cascade do |t|
    t.integer "member_id"
    t.integer "instrument_id"
  end

  add_index "member_instruments", ["instrument_id"], name: "index_member_instruments_on_instrument_id", using: :btree
  add_index "member_instruments", ["member_id"], name: "index_member_instruments_on_member_id", using: :btree

  create_table "member_translations", force: :cascade do |t|
    t.integer  "member_id",   null: false
    t.string   "locale",      null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "first_name"
    t.string   "surname"
    t.text     "description"
  end

  add_index "member_translations", ["locale"], name: "index_member_translations_on_locale", using: :btree
  add_index "member_translations", ["member_id"], name: "index_member_translations_on_member_id", using: :btree

  create_table "members", force: :cascade do |t|
    t.string  "first_name"
    t.text    "description"
    t.integer "position"
    t.string  "surname"
  end

  create_table "messages", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "viewed",     default: false
  end

  create_table "pictures", force: :cascade do |t|
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "pictures", ["imageable_type", "imageable_id"], name: "index_pictures_on_imageable_type_and_imageable_id", using: :btree

  create_table "riders", force: :cascade do |t|
    t.string   "title"
    t.string   "document_file_name"
    t.string   "document_content_type"
    t.integer  "document_file_size"
    t.datetime "document_updated_at"
  end

end
