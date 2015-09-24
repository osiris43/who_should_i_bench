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

ActiveRecord::Schema.define(version: 20140929171531) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "fantasy_league_sites", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fantasy_leagues", force: true do |t|
    t.integer  "fantasy_league_site_id"
    t.string   "league_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fantasy_leagues", ["fantasy_league_site_id"], name: "index_fantasy_leagues_on_fantasy_league_site_id", using: :btree

  create_table "nfl_game_passing_stats", force: true do |t|
    t.integer  "nfl_player_id"
    t.integer  "nfl_game_id"
    t.integer  "completions"
    t.integer  "attempts"
    t.integer  "yards"
    t.integer  "tds"
    t.integer  "interceptions"
    t.integer  "sacks"
    t.integer  "sack_yards"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "nfl_game_passing_stats", ["nfl_game_id"], name: "index_nfl_game_passing_stats_on_nfl_game_id", using: :btree
  add_index "nfl_game_passing_stats", ["nfl_player_id"], name: "index_nfl_game_passing_stats_on_nfl_player_id", using: :btree

  create_table "nfl_game_receiving_stats", force: true do |t|
    t.integer  "nfl_player_id"
    t.integer  "nfl_game_id"
    t.integer  "receptions"
    t.integer  "yards"
    t.integer  "tds"
    t.integer  "longest"
    t.integer  "targets"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "nfl_game_receiving_stats", ["nfl_game_id"], name: "index_nfl_game_receiving_stats_on_nfl_game_id", using: :btree
  add_index "nfl_game_receiving_stats", ["nfl_player_id"], name: "index_nfl_game_receiving_stats_on_nfl_player_id", using: :btree

  create_table "nfl_game_rushing_stats", force: true do |t|
    t.integer  "nfl_player_id"
    t.integer  "nfl_game_id"
    t.integer  "carries"
    t.integer  "yards"
    t.integer  "tds"
    t.integer  "longest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "nfl_game_rushing_stats", ["nfl_game_id"], name: "index_nfl_game_rushing_stats_on_nfl_game_id", using: :btree
  add_index "nfl_game_rushing_stats", ["nfl_player_id"], name: "index_nfl_game_rushing_stats_on_nfl_player_id", using: :btree

  create_table "nfl_games", force: true do |t|
    t.integer  "away_team_id"
    t.integer  "home_team_id"
    t.integer  "season"
    t.integer  "week"
    t.integer  "nfl_season_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "gamedate"
  end

  add_index "nfl_games", ["nfl_season_type_id"], name: "index_nfl_games_on_nfl_season_type_id", using: :btree

  create_table "nfl_player_scores", force: true do |t|
    t.integer  "nfl_player_id"
    t.integer  "season"
    t.integer  "week"
    t.float    "score"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "fantasy_league_id"
  end

  add_index "nfl_player_scores", ["nfl_player_id"], name: "index_nfl_player_scores_on_nfl_player_id", using: :btree

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

  create_table "nfl_season_types", force: true do |t|
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "nfl_team_passing_stats", force: true do |t|
    t.integer  "nfl_game_id"
    t.integer  "nfl_team_id"
    t.integer  "yards"
    t.integer  "completions"
    t.integer  "attempts"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "nfl_team_passing_stats", ["nfl_game_id"], name: "index_nfl_team_passing_stats_on_nfl_game_id", using: :btree
  add_index "nfl_team_passing_stats", ["nfl_team_id"], name: "index_nfl_team_passing_stats_on_nfl_team_id", using: :btree

  create_table "nfl_team_rushing_stats", force: true do |t|
    t.integer  "nfl_game_id"
    t.integer  "nfl_team_id"
    t.integer  "yards"
    t.integer  "attempts"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "nfl_team_rushing_stats", ["nfl_game_id"], name: "index_nfl_team_rushing_stats_on_nfl_game_id", using: :btree
  add_index "nfl_team_rushing_stats", ["nfl_team_id"], name: "index_nfl_team_rushing_stats_on_nfl_team_id", using: :btree

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
