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

ActiveRecord::Schema.define(version: 20140904123259) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "nfl_players", force: true do |t|
    t.integer  "nfl_team_id"
    t.string   "firstname"
    t.string   "lastname"
    t.integer  "nfl_position_id"
    t.string   "myfantasyleagueid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "nfl_players", ["nfl_position_id"], name: "index_nfl_players_on_nfl_position_id", using: :btree
  add_index "nfl_players", ["nfl_team_id"], name: "index_nfl_players_on_nfl_team_id", using: :btree

  create_table "nfl_positions", force: true do |t|
    t.string   "abbreviation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nfl_teams", force: true do |t|
    t.string   "city"
    t.string   "mascot"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "abbreviation"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
