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

ActiveRecord::Schema.define(version: 2022_03_23_012838) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "bets", force: :cascade do |t|
    t.bigint "hand_id", null: false
    t.integer "amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.index ["hand_id"], name: "index_bets_on_hand_id"
    t.index ["user_id"], name: "index_bets_on_user_id"
  end

  create_table "deck_cards", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "url"
    t.string "code"
  end

  create_table "deleted_cards", force: :cascade do |t|
    t.bigint "hand_id", null: false
    t.bigint "deck_card_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["deck_card_id"], name: "index_deleted_cards_on_deck_card_id"
    t.index ["hand_id"], name: "index_deleted_cards_on_hand_id"
  end

  create_table "flop_cards", force: :cascade do |t|
    t.bigint "deck_card_id", null: false
    t.bigint "hand_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["deck_card_id"], name: "index_flop_cards_on_deck_card_id"
    t.index ["hand_id"], name: "index_flop_cards_on_hand_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "sb_amount"
    t.integer "bb_amount"
    t.integer "max_bet_amount"
    t.integer "hand_limit"
    t.integer "amount_played"
    t.integer "hand_count"
  end

  create_table "hand_winners", force: :cascade do |t|
    t.bigint "hand_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "winner_id"
    t.index ["hand_id"], name: "index_hand_winners_on_hand_id"
    t.index ["winner_id"], name: "index_hand_winners_on_winner_id"
  end

  create_table "hands", force: :cascade do |t|
    t.bigint "game_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "active"
    t.bigint "button_id"
    t.bigint "small_blind_id"
    t.bigint "big_blind_id"
    t.bigint "better_id"
    t.integer "remainder"
    t.integer "pot"
    t.string "name"
    t.index ["better_id"], name: "index_hands_on_better_id"
    t.index ["big_blind_id"], name: "index_hands_on_big_blind_id"
    t.index ["button_id"], name: "index_hands_on_button_id"
    t.index ["game_id"], name: "index_hands_on_game_id"
    t.index ["small_blind_id"], name: "index_hands_on_small_blind_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "game_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "score"
    t.boolean "active"
    t.index ["game_id"], name: "index_reservations_on_game_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "river_cards", force: :cascade do |t|
    t.bigint "deck_card_id", null: false
    t.bigint "hand_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["deck_card_id"], name: "index_river_cards_on_deck_card_id"
    t.index ["hand_id"], name: "index_river_cards_on_hand_id"
  end

  create_table "turn_cards", force: :cascade do |t|
    t.bigint "deck_card_id", null: false
    t.bigint "hand_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["deck_card_id"], name: "index_turn_cards_on_deck_card_id"
    t.index ["hand_id"], name: "index_turn_cards_on_hand_id"
  end

  create_table "user_cards", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "deck_card_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "hand_id", null: false
    t.index ["deck_card_id"], name: "index_user_cards_on_deck_card_id"
    t.index ["hand_id"], name: "index_user_cards_on_hand_id"
    t.index ["user_id"], name: "index_user_cards_on_user_id"
  end

  create_table "user_hands", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "hand_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "active"
    t.string "rank"
    t.string "odds"
    t.index ["hand_id"], name: "index_user_hands_on_hand_id"
    t.index ["user_id"], name: "index_user_hands_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.string "pseudo"
    t.bigint "best_hand_id"
    t.bigint "worst_hand_id"
    t.integer "biggest_win"
    t.integer "biggest_loss"
    t.integer "hand_played"
    t.integer "hand_won"
    t.index ["best_hand_id"], name: "index_users_on_best_hand_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["worst_hand_id"], name: "index_users_on_worst_hand_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "bets", "hands"
  add_foreign_key "bets", "users"
  add_foreign_key "deleted_cards", "deck_cards"
  add_foreign_key "deleted_cards", "hands"
  add_foreign_key "flop_cards", "deck_cards"
  add_foreign_key "flop_cards", "hands"
  add_foreign_key "hand_winners", "hands"
  add_foreign_key "hand_winners", "users", column: "winner_id"
  add_foreign_key "hands", "games"
  add_foreign_key "hands", "users", column: "better_id"
  add_foreign_key "hands", "users", column: "big_blind_id"
  add_foreign_key "hands", "users", column: "button_id"
  add_foreign_key "hands", "users", column: "small_blind_id"
  add_foreign_key "reservations", "games"
  add_foreign_key "reservations", "users"
  add_foreign_key "river_cards", "deck_cards"
  add_foreign_key "river_cards", "hands"
  add_foreign_key "turn_cards", "deck_cards"
  add_foreign_key "turn_cards", "hands"
  add_foreign_key "user_cards", "deck_cards"
  add_foreign_key "user_cards", "hands"
  add_foreign_key "user_cards", "users"
  add_foreign_key "user_hands", "hands"
  add_foreign_key "user_hands", "users"
  add_foreign_key "users", "hands", column: "best_hand_id"
  add_foreign_key "users", "hands", column: "worst_hand_id"
end
