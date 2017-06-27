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

ActiveRecord::Schema.define(version: 20170627143355) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "memberships", force: :cascade do |t|
    t.integer  "team_id",    null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id", "user_id"], name: "index_memberships_on_team_id_and_user_id", unique: true, using: :btree
    t.index ["team_id"], name: "index_memberships_on_team_id", using: :btree
    t.index ["user_id"], name: "index_memberships_on_user_id", using: :btree
  end

  create_table "nominations", force: :cascade do |t|
    t.string   "body",                         null: false
    t.integer  "nominator_id",                 null: false
    t.integer  "nominee_id",                   null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "team_id",                      null: false
    t.integer  "votes_count"
    t.boolean  "archived",     default: false
    t.index ["nominator_id"], name: "index_nominations_on_nominator_id", using: :btree
    t.index ["nominee_id"], name: "index_nominations_on_nominee_id", using: :btree
  end

  create_table "teams", force: :cascade do |t|
    t.boolean  "active",         default: true, null: false
    t.string   "name",                          null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "vote_threshold", default: 1,    null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.integer  "github_id"
    t.string   "handle"
    t.string   "image_url"
    t.integer  "launch_pass_id"
    t.string   "name"
    t.integer  "sign_in_count",   default: 0
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "default_team_id"
    t.boolean  "active",          default: true
    t.index ["github_id"], name: "index_users_on_github_id", unique: true, using: :btree
    t.index ["handle"], name: "index_users_on_handle", unique: true, using: :btree
  end

  create_table "votes", force: :cascade do |t|
    t.integer  "nomination_id", null: false
    t.integer  "user_id",       null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["nomination_id", "user_id"], name: "index_votes_on_nomination_id_and_user_id", unique: true, using: :btree
    t.index ["nomination_id"], name: "index_votes_on_nomination_id", using: :btree
    t.index ["user_id"], name: "index_votes_on_user_id", using: :btree
  end

end
