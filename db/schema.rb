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

ActiveRecord::Schema.define(version: 20170427133410) do

  create_table "actors", force: :cascade do |t|
    t.string   "name"
    t.string   "tmdb_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "actors_users", force: :cascade do |t|
    t.integer  "actor_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "actors_users", ["actor_id"], name: "index_actors_users_on_actor_id"
  add_index "actors_users", ["user_id"], name: "index_actors_users_on_user_id"

  create_table "matches", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "matches_actors", force: :cascade do |t|
    t.integer  "match_id"
    t.integer  "actor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "matches_actors", ["actor_id"], name: "index_matches_actors_on_actor_id"
  add_index "matches_actors", ["match_id"], name: "index_matches_actors_on_match_id"

  create_table "matches_movies", force: :cascade do |t|
    t.integer  "match_id"
    t.integer  "movie_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "matches_movies", ["match_id"], name: "index_matches_movies_on_match_id"
  add_index "matches_movies", ["movie_id"], name: "index_matches_movies_on_movie_id"

  create_table "matches_users", force: :cascade do |t|
    t.integer  "match_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "matches_users", ["match_id"], name: "index_matches_users_on_match_id"
  add_index "matches_users", ["user_id"], name: "index_matches_users_on_user_id"

  create_table "movies", force: :cascade do |t|
    t.string   "title"
    t.string   "tmdb_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "movies_actors", force: :cascade do |t|
    t.integer  "movie_id"
    t.integer  "actor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "movies_actors", ["actor_id"], name: "index_movies_actors_on_actor_id"
  add_index "movies_actors", ["movie_id"], name: "index_movies_actors_on_movie_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "password_hash"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

end
