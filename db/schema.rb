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

ActiveRecord::Schema.define(version: 2018_11_16_060637) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "resource_type"
    t.integer "resource_id"
    t.string "author_type"
    t.integer "author_id"
    t.string "namespace"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "associations", force: :cascade do |t|
    t.string "associatiable_type"
    t.integer "associatiable_id"
    t.string "associated_type"
    t.integer "associated_id"
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["associated_type", "associated_id"], name: "index_associations_on_associated_type_and_associated_id"
    t.index ["associatiable_type", "associatiable_id"], name: "index_associations_on_associatiable_type_and_associatiable_id"
  end

  create_table "claims", force: :cascade do |t|
    t.integer "hubspot_id"
    t.string "type"
    t.string "first"
    t.string "last"
    t.string "email"
    t.string "phone"
    t.string "mobile"
    t.string "postcode"
    t.text "address"
    t.string "company_name"
    t.string "company_contact"
    t.string "company_email"
    t.string "company_phone"
    t.text "company_address"
    t.string "company_postcode"
    t.integer "received"
    t.date "from"
    t.date "to"
    t.integer "escalation"
    t.boolean "insurance"
    t.boolean "signed"
    t.boolean "shown"
    t.boolean "inspected"
    t.boolean "employee"
    t.boolean "noted"
    t.boolean "acknowledge"
    t.boolean "report"
    t.boolean "subsequent"
    t.boolean "card"
    t.boolean "invoice"
    t.boolean "images"
    t.boolean "repair"
    t.boolean "method"
    t.boolean "additional"
    t.boolean "vat"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "nodes", force: :cascade do |t|
    t.integer "user_id"
    t.string "type"
    t.string "slug"
    t.string "ref"
    t.text "val"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_nodes_on_user_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.integer "user_id"
    t.string "slug"
    t.string "name"
    t.integer "role", default: 0
    t.integer "sound_fx", limit: 1, default: 60
    t.integer "ambient_sound", limit: 1, default: 60
    t.boolean "public", default: false
    t.boolean "is_destroyable"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_slugs_on_sluggable_type"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
