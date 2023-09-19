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

ActiveRecord::Schema[7.0].define(version: 2023_09_19_072335) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.text "body", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "line_id", null: false
    t.index ["line_id"], name: "index_comments_on_line_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "line_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["line_id"], name: "index_likes_on_line_id"
    t.index ["user_id", "line_id"], name: "index_likes_on_user_id_and_line_id", unique: true
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "line_categories", force: :cascade do |t|
    t.bigint "line_id", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_line_categories_on_category_id"
    t.index ["line_id"], name: "index_line_categories_on_line_id"
  end

  create_table "lines", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.text "line_url"
    t.string "image"
    t.string "recommended_train_window_spot", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "prefecture_lines", force: :cascade do |t|
    t.bigint "prefecture_id", null: false
    t.bigint "line_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["line_id"], name: "index_prefecture_lines_on_line_id"
    t.index ["prefecture_id"], name: "index_prefecture_lines_on_prefecture_id"
  end

  create_table "prefectures", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "comments", "lines"
  add_foreign_key "comments", "users"
  add_foreign_key "likes", "lines"
  add_foreign_key "likes", "users"
  add_foreign_key "line_categories", "categories"
  add_foreign_key "line_categories", "lines"
  add_foreign_key "prefecture_lines", "lines"
  add_foreign_key "prefecture_lines", "prefectures"
end
