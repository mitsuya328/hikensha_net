# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_02_15_092712) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "experiments", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "deadline"
    t.string "picture"
    t.string "location"
    t.string "reward"
    t.integer "amount_of_reward"
    t.index ["user_id", "created_at"], name: "index_experiments_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_experiments_on_user_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "examiner_id"
    t.integer "examinee_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["examiner_id", "examinee_id"], name: "index_relationships_on_examiner_id_and_examinee_id", unique: true
    t.index ["examiner_id"], name: "index_relationships_on_examiner_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.string "email"
    t.string "sex"
    t.date "birth_date"
    t.text "note"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "timetable_id", null: false
    t.bigint "user_id"
    t.bigint "experiment_id"
    t.index ["experiment_id"], name: "index_subjects_on_experiment_id"
    t.index ["timetable_id"], name: "index_subjects_on_timetable_id"
    t.index ["user_id"], name: "index_subjects_on_user_id"
  end

  create_table "timetables", force: :cascade do |t|
    t.datetime "start_at"
    t.bigint "experiment_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "number_of_subjects"
    t.index ["experiment_id", "start_at"], name: "index_timetables_on_experiment_id_and_start_at"
    t.index ["experiment_id"], name: "index_timetables_on_experiment_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.string "sex"
    t.date "birth_date"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "experiments", "users"
  add_foreign_key "subjects", "experiments"
  add_foreign_key "subjects", "users"
  add_foreign_key "timetables", "experiments"
end
