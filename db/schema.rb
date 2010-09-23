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

ActiveRecord::Schema.define(:version => 20100923145735) do

  create_table "bar_codes", :force => true do |t|
    t.string   "type",                            :null => false
    t.string   "origin"
    t.string   "tel"
    t.string   "text"
    t.text     "source",      :limit => 16777215
    t.integer  "version"
    t.string   "level"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "campaign_id"
  end

  add_index "bar_codes", ["id", "type"], :name => "index_bar_codes_on_id_and_type", :unique => true

  create_table "campaigns", :force => true do |t|
    t.string   "title"
    t.string   "state",      :default => "unpublished"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cities", :force => true do |t|
    t.string   "name",       :limit => 36, :null => false
    t.string   "display",    :limit => 36
    t.integer  "region_id",                :null => false
    t.integer  "country_id",               :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cities", ["country_id"], :name => "index_cities_on_country_id"
  add_index "cities", ["name", "country_id", "region_id"], :name => "index_cities_on_name_and_country_id_and_region_id"
  add_index "cities", ["name"], :name => "index_cities_on_name"
  add_index "cities", ["region_id"], :name => "index_cities_on_region_id"

  create_table "clicks", :force => true do |t|
    t.string   "ip_address",    :limit => 15,                     :null => false
    t.string   "referer",       :limit => 128
    t.integer  "user_agent_id",                :default => 1,     :null => false
    t.integer  "short_url_id",                                    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "country_id"
    t.integer  "region_id"
    t.integer  "city_id"
    t.boolean  "located",                      :default => false
  end

  add_index "clicks", ["short_url_id", "created_at"], :name => "index_clicks_on_short_url_id_and_created_at"
  add_index "clicks", ["short_url_id"], :name => "index_clicks_on_short_url_id"
  add_index "clicks", ["user_agent_id"], :name => "index_clicks_on_user_agent_id"

  create_table "countries", :force => true do |t|
    t.string   "name",       :limit => 36, :null => false
    t.string   "code",       :limit => 3,  :null => false
    t.string   "display",    :limit => 36
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "countries", ["code"], :name => "index_countries_on_code"
  add_index "countries", ["name", "code"], :name => "index_countries_on_name_and_code"
  add_index "countries", ["name"], :name => "index_countries_on_name"

  create_table "mobiles", :force => true do |t|
    t.string   "manufacturer"
    t.string   "model"
    t.string   "resolution"
    t.integer  "width",        :default => 0
    t.integer  "height",       :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "regions", :force => true do |t|
    t.string   "name",       :limit => 36
    t.string   "code",                     :null => false
    t.string   "display",    :limit => 36
    t.integer  "country_id",               :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "regions", ["code", "country_id"], :name => "index_regions_on_code_and_country_id"
  add_index "regions", ["code"], :name => "index_regions_on_code"
  add_index "regions", ["country_id"], :name => "index_regions_on_country_id"
  add_index "regions", ["name"], :name => "index_regions_on_name"

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
    t.integer  "campaign_id"
  end

  add_index "short_urls", ["short"], :name => "index_short_urls_on_short", :unique => true

  create_table "summarized_clicks", :force => true do |t|
    t.integer  "clicks",       :null => false
    t.integer  "city_id"
    t.integer  "country_id"
    t.integer  "region_id"
    t.integer  "short_url_id", :null => false
    t.string   "percent",      :null => false
    t.date     "date",         :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "summarized_clicks", ["short_url_id", "date"], :name => "index_summarized_clicks_on_short_url_id_and_date"
  add_index "summarized_clicks", ["short_url_id"], :name => "index_summarized_clicks_on_short_url_id"

  create_table "user_agents", :force => true do |t|
    t.string   "details",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
