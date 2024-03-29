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

ActiveRecord::Schema[7.0].define(version: 2021_12_25_164841) do
  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "service_name", null: false
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.integer "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "racers", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.integer "position", default: 0, null: false
    t.integer "damage", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "race_id"
    t.integer "rank"
    t.index ["race_id"], name: "index_racers_on_race_id"
  end

  create_table "races", force: :cascade do |t|
    t.integer "finish_line", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "current_rank"
  end

  create_table "rolls", force: :cascade do |t|
    t.integer "race_id"
    t.integer "racer_id"
    t.integer "position", null: false
    t.integer "damage", null: false
    t.string "speed", null: false
    t.integer "roll", null: false
    t.integer "move", null: false
    t.integer "new_position", null: false
    t.integer "new_damage", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "crashed", default: false, null: false
    t.boolean "won", default: false, null: false
    t.index ["race_id"], name: "index_rolls_on_race_id"
    t.index ["racer_id"], name: "index_rolls_on_racer_id"
  end

  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
end
