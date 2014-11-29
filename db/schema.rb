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

ActiveRecord::Schema.define(version: 20141129205302) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "autonomous_communities", force: true do |t|
    t.string  "name"
    t.integer "country_id"
  end

  create_table "censuses", force: true do |t|
    t.integer "election_id"
    t.integer "provice_id"
    t.integer "population"
    t.integer "number_of_tables"
    t.integer "electoral_census"
    t.integer "electoral_census_without_cera"
    t.integer "electoral_census_cera"
    t.integer "electoral_census_total"
    t.integer "applications_for_cera_accepted"
    t.integer "total_cer_voters"
    t.integer "total_cera_voters"
    t.integer "total_voters"
    t.integer "valid_votes"
    t.integer "votes_for_parties"
    t.integer "votes_blank"
    t.integer "votes_null"
    t.integer "seats"
  end

  create_table "countries", force: true do |t|
    t.string  "name"
    t.integer "population"
    t.integer "congress_seats"
  end

  create_table "elections", force: true do |t|
    t.string   "name"
    t.string   "type"
    t.datetime "election_day"
    t.integer  "country_id"
  end

  create_table "parties", force: true do |t|
    t.string   "name"
    t.string   "acronym"
    t.integer  "country_id"
    t.datetime "foundation"
    t.string   "color"
  end

  create_table "provinces", force: true do |t|
    t.string  "name"
    t.integer "province_code"
    t.integer "autonomous_community_id"
  end

  create_table "results", force: true do |t|
    t.integer "census_id"
    t.integer "party_id"
    t.integer "votes"
    t.integer "seats"
  end

end
