# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100504172103) do

  create_table "bar_codes", :force => true do |t|
    t.string   "type",                           :null => false
    t.string   "origin"
    t.string   "tel"
    t.string   "text"
    t.text     "source",     :limit => 16777215
    t.integer  "version"
    t.string   "level"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bar_codes", ["id", "type"], :name => "index_bar_codes_on_id_and_type", :unique => true

  create_table "clicks", :force => true do |t|
    t.string   "ip_address",    :limit => 15,                 :null => false
    t.string   "referer",       :limit => 128
    t.integer  "user_agent_id",                :default => 1, :null => false
    t.integer  "short_url_id",                                :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "clicks", ["short_url_id"], :name => "index_clicks_on_short_url_id"
  add_index "clicks", ["user_agent_id"], :name => "index_clicks_on_user_agent_id"

  create_table "short_sequences", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "short_urls", :force => true do |t|
    t.string   "origin",                      :null => false
    t.string   "short",                       :null => false
    t.integer  "clicks_count", :default => 0, :null => false
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "short_urls", ["short"], :name => "index_short_urls_on_short", :unique => true

  create_table "user_agents", :force => true do |t|
    t.string   "details",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
