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

ActiveRecord::Schema[7.0].define(version: 2024_04_24_165226) do
  create_table "act_gigs", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "acts", force: :cascade do |t|
    t.string "name"
    t.string "weblink"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "original"
  end

  create_table "acts_gigs", force: :cascade do |t|
    t.integer "act_id"
    t.integer "gig_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["act_id"], name: "index_acts_gigs_on_act_id"
    t.index ["gig_id"], name: "index_acts_gigs_on_gig_id"
  end

  create_table "analytics_events", force: :cascade do |t|
    t.string "path"
    t.string "method"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ip_address"
    t.string "user_agent"
  end

  create_table "gigs", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "venue"
    t.string "socials"
    t.date "date"
    t.time "doors"
    t.string "event_link"
  end

  create_table "subscribers", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "string"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "venues", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "acts_gigs", "acts"
  add_foreign_key "acts_gigs", "gigs"
end
