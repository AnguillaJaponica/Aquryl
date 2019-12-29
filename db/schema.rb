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

ActiveRecord::Schema.define(version: 2019_12_29_100624) do

  create_table "species", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "scientific_name", default: "", null: false
    t.string "author_name", default: "", null: false
    t.string "japanese_name", default: ""
    t.string "japanese_phonetic_spell", default: ""
    t.string "chinese_name", default: ""
    t.string "chinese_phonetic_spell", default: ""
    t.string "korean_name", default: ""
    t.string "korean_phonetic_spell", default: ""
    t.string "english_name", default: ""
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
