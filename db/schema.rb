# frozen_string_literal: true

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

ActiveRecord::Schema[7.0].define(version: 20_221_103_203_605) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'branches', force: :cascade do |t|
    t.bigint 'leaf_id', null: false
    t.bigint 'pair_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['leaf_id'], name: 'index_branches_on_leaf_id'
    t.index ['pair_id'], name: 'index_branches_on_pair_id'
  end

  create_table 'leafs', force: :cascade do |t|
    t.string 'name'
    t.string 'gender'
    t.string 'alive'
    t.date 'birth'
    t.date 'death'
    t.string 'description'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'pairs', force: :cascade do |t|
    t.date 'marriage'
    t.date 'separation'
    t.string 'local'
    t.integer 'leaf1_id', null: false
    t.integer 'leaf2_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  add_foreign_key 'branches', 'leafs'
  add_foreign_key 'branches', 'pairs'
  add_foreign_key 'pairs', 'leafs', column: 'leaf1_id'
  add_foreign_key 'pairs', 'leafs', column: 'leaf2_id'
end
