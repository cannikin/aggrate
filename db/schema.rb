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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120106045853) do

  create_table "entries", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "image"
    t.datetime "pub_time"
    t.string   "guid"
    t.integer  "source_id"
    t.string   "source_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "entries", ["guid"], :name => "index_entries_on_guid"
  add_index "entries", ["source_id", "source_type"], :name => "index_entries_on_source_id_and_source_type"

  create_table "feeds", :force => true do |t|
    t.string   "link"
    t.string   "title"
    t.datetime "last_checked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
