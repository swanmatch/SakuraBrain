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

ActiveRecord::Schema.define(version: 20170724052249) do

  create_table "places", force: :cascade do |t|
    t.string   "cd",           limit: 255
    t.string   "name",         limit: 255
    t.integer  "lock_version", limit: 4,   default: 0, null: false
    t.integer  "created_by",   limit: 4
    t.integer  "updated_by",   limit: 4
    t.integer  "deleted_by",   limit: 4
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "places", ["cd"], name: "index_places_on_cd", using: :btree

  create_table "sakuras", force: :cascade do |t|
    t.integer  "place_id",     limit: 4
    t.integer  "year",         limit: 4
    t.integer  "open_on",      limit: 4
    t.integer  "full_on",      limit: 4
    t.integer  "lock_version", limit: 4, default: 0, null: false
    t.integer  "created_by",   limit: 4
    t.integer  "updated_by",   limit: 4
    t.integer  "deleted_by",   limit: 4
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sakuras", ["full_on"], name: "index_sakuras_on_full_on", using: :btree
  add_index "sakuras", ["open_on"], name: "index_sakuras_on_open_on", using: :btree
  add_index "sakuras", ["place_id"], name: "index_sakuras_on_place_id", using: :btree
  add_index "sakuras", ["year"], name: "index_sakuras_on_year", using: :btree

  create_table "temps", force: :cascade do |t|
    t.integer  "place_id",     limit: 4
    t.date     "temp_on"
    t.integer  "average",      limit: 4
    t.integer  "max",          limit: 4
    t.integer  "min",          limit: 4
    t.integer  "lock_version", limit: 4, default: 0, null: false
    t.integer  "created_by",   limit: 4
    t.integer  "updated_by",   limit: 4
    t.integer  "deleted_by",   limit: 4
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "temps", ["average"], name: "index_temps_on_average", using: :btree
  add_index "temps", ["max"], name: "index_temps_on_max", using: :btree
  add_index "temps", ["min"], name: "index_temps_on_min", using: :btree
  add_index "temps", ["place_id"], name: "index_temps_on_place_id", using: :btree
  add_index "temps", ["temp_on"], name: "index_temps_on_temp_on", using: :btree

end
