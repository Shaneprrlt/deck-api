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

ActiveRecord::Schema.define(version: 20170424042743) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "apps", force: :cascade do |t|
    t.string   "name"
    t.integer  "platform_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "removed",     default: false, null: false
  end

  create_table "card_followers", force: :cascade do |t|
    t.integer  "card_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_card_followers_on_card_id", using: :btree
    t.index ["user_id"], name: "index_card_followers_on_user_id", using: :btree
  end

  create_table "card_labels", force: :cascade do |t|
    t.integer  "card_id"
    t.integer  "label_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_card_labels_on_card_id", using: :btree
    t.index ["label_id"], name: "index_card_labels_on_label_id", using: :btree
  end

  create_table "card_occurences", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "card_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_card_occurences_on_card_id", using: :btree
    t.index ["user_id"], name: "index_card_occurences_on_user_id", using: :btree
  end

  create_table "card_types", force: :cascade do |t|
    t.string   "name"
    t.string   "icon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cards", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "card_type_id"
    t.integer  "app_id"
    t.string   "title"
    t.string   "description"
    t.integer  "state"
    t.string   "uuid"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["app_id"], name: "index_cards_on_app_id", using: :btree
    t.index ["user_id"], name: "index_cards_on_user_id", using: :btree
  end

  create_table "deck_cards", force: :cascade do |t|
    t.integer  "deck_id"
    t.integer  "card_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_deck_cards_on_card_id", using: :btree
    t.index ["deck_id"], name: "index_deck_cards_on_deck_id", using: :btree
  end

  create_table "deck_labels", force: :cascade do |t|
    t.integer  "deck_id"
    t.integer  "label_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deck_id"], name: "index_deck_labels_on_deck_id", using: :btree
    t.index ["label_id"], name: "index_deck_labels_on_label_id", using: :btree
  end

  create_table "decks", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_decks_on_user_id", using: :btree
  end

  create_table "invitations", force: :cascade do |t|
    t.string   "email"
    t.boolean  "admin",      default: false, null: false
    t.boolean  "accepted",   default: false, null: false
    t.datetime "resent_at"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "labels", force: :cascade do |t|
    t.string   "title"
    t.integer  "app_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["app_id"], name: "index_labels_on_app_id", using: :btree
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "card_id"
    t.string   "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_messages_on_card_id", using: :btree
    t.index ["user_id"], name: "index_messages_on_user_id", using: :btree
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "action"
    t.string   "actor_type"
    t.integer  "actor_id"
    t.string   "target_type"
    t.integer  "target_id"
    t.boolean  "read",        default: false, null: false
    t.string   "uuid"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["actor_type", "actor_id"], name: "index_notifications_on_actor_type_and_actor_id", using: :btree
    t.index ["target_type", "target_id"], name: "index_notifications_on_target_type_and_target_id", using: :btree
    t.index ["user_id"], name: "index_notifications_on_user_id", using: :btree
  end

  create_table "platforms", force: :cascade do |t|
    t.string   "name"
    t.string   "icon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
    t.index ["name"], name: "index_roles_on_name", using: :btree
  end

  create_table "settings", force: :cascade do |t|
    t.string   "var",                   null: false
    t.text     "value"
    t.integer  "thing_id"
    t.string   "thing_type", limit: 30
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["thing_type", "thing_id", "var"], name: "index_settings_on_thing_type_and_thing_id_and_var", unique: true, using: :btree
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.string   "subdomain"
    t.string   "email"
    t.string   "timezone"
    t.boolean  "blocked",    default: false, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "username"
    t.string   "name"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "password_digest"
    t.string   "timezone"
    t.string   "phone"
    t.boolean  "blocked",         default: false, null: false
    t.integer  "invitation_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["invitation_id"], name: "index_users_on_invitation_id", using: :btree
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree
  end

  add_foreign_key "card_followers", "cards"
  add_foreign_key "card_followers", "users"
  add_foreign_key "card_labels", "cards"
  add_foreign_key "card_labels", "labels"
  add_foreign_key "card_occurences", "cards"
  add_foreign_key "card_occurences", "users"
  add_foreign_key "cards", "apps"
  add_foreign_key "cards", "users"
  add_foreign_key "deck_cards", "cards"
  add_foreign_key "deck_cards", "decks"
  add_foreign_key "deck_labels", "decks"
  add_foreign_key "deck_labels", "labels"
  add_foreign_key "decks", "users"
  add_foreign_key "labels", "apps"
  add_foreign_key "messages", "cards"
  add_foreign_key "messages", "users"
  add_foreign_key "notifications", "users"
end
