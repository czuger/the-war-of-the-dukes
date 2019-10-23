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

ActiveRecord::Schema.define(version: 20191023115637) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "board_histories", force: :cascade do |t|
    t.bigint "board_id", null: false
    t.integer "turn", limit: 2, null: false
    t.integer "movements_increments", default: 1, null: false
    t.jsonb "pawns_positions", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["board_id"], name: "index_board_histories_on_board_id"
  end

  create_table "boards", force: :cascade do |t|
    t.bigint "owner_id", null: false
    t.integer "turn", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "aasm_state"
    t.string "fight_data"
    t.integer "orf_id", null: false
    t.integer "wulf_id", null: false
    t.string "current_side", null: false
    t.string "retreating_pawn", null: false
    t.index ["orf_id"], name: "index_boards_on_orf_id"
    t.index ["owner_id"], name: "index_boards_on_owner_id"
    t.index ["wulf_id"], name: "index_boards_on_wulf_id"
  end

  create_table "pawns", force: :cascade do |t|
    t.integer "q", null: false
    t.integer "r", null: false
    t.string "pawn_type", null: false
    t.string "side", null: false
    t.bigint "board_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "remaining_movement", null: false
    t.index ["board_id", "q", "r"], name: "index_pawns_on_board_id_and_q_and_r"
    t.index ["board_id"], name: "index_pawns_on_board_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider", null: false
    t.string "uid", null: false
    t.index ["uid"], name: "index_players_on_uid", unique: true
  end

  add_foreign_key "board_histories", "boards"
  add_foreign_key "boards", "players", column: "orf_id"
  add_foreign_key "boards", "players", column: "owner_id"
  add_foreign_key "boards", "players", column: "wulf_id"
  add_foreign_key "pawns", "boards"
end
