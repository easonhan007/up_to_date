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

ActiveRecord::Schema[7.0].define(version: 2023_09_09_054225) do
  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
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
    t.index ["category_id"], name: "index_crawler_settings_on_category_id"
    t.index ["user_id"], name: "index_crawler_settings_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.string "from"
    t.integer "crawler_record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "crawler_setting_id", null: false
    t.index ["crawler_record_id"], name: "index_posts_on_crawler_record_id"
    t.index ["crawler_setting_id"], name: "index_posts_on_crawler_setting_id"
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
  add_foreign_key "posts", "crawler_records"
  add_foreign_key "posts", "crawler_settings"
end
