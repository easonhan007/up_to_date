# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_04_14_043042) do
  create_table "api_call_records", force: :cascade do |t|
    t.integer "post_id"
    t.integer "post_target_id"
    t.integer "status_code"
    t.text "log"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.integer "weight", default: 0
    t.index ["user_id"], name: "index_categories_on_user_id"
  end

  create_table "crawler_records", force: :cascade do |t|
    t.integer "url_count"
    t.integer "success"
    t.integer "failed"
    t.text "urls"
    t.integer "crawler_setting_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "log"
    t.index ["crawler_setting_id"], name: "index_crawler_records_on_crawler_setting_id"
  end

  create_table "crawler_settings", force: :cascade do |t|
    t.string "name"
    t.string "index_page_url"
    t.string "index_page_css"
    t.string "detail_page_title_css"
    t.string "detail_page_content_css"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "detail_page_clean_up_css"
    t.integer "category_id", default: 1
    t.string "image_keyword"
    t.boolean "active", default: false
    t.index ["category_id"], name: "index_crawler_settings_on_category_id"
    t.index ["user_id"], name: "index_crawler_settings_on_user_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "post_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_favorites_on_post_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "post_targets", force: :cascade do |t|
    t.string "api"
    t.string "key"
    t.text "headers", default: "{\"Content-Type\": \"application/json\"}"
    t.text "field_mapping"
    t.integer "success_code", default: 200
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "query"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.string "from"
    t.integer "crawler_record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "crawler_setting_id", null: false
    t.string "slug"
    t.string "image_url"
    t.index ["crawler_record_id"], name: "index_posts_on_crawler_record_id"
    t.index ["crawler_setting_id"], name: "index_posts_on_crawler_setting_id"
  end

  create_table "settings", force: :cascade do |t|
    t.string "name"
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "categories", "users"
  add_foreign_key "crawler_records", "crawler_settings"
  add_foreign_key "crawler_settings", "categories"
  add_foreign_key "crawler_settings", "users"
  add_foreign_key "favorites", "posts"
  add_foreign_key "favorites", "users"
  add_foreign_key "posts", "crawler_records"
  add_foreign_key "posts", "crawler_settings"
end
