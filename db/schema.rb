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

ActiveRecord::Schema.define(:version => 20110331121410) do

  create_table "accounts", :force => true do |t|
    t.string   "title"
    t.string   "contact_phone"
    t.string   "contact_person"
    t.string   "address"
    t.string   "city"
    t.string   "bank_account"
    t.string   "state"
    t.string   "kind_of",        :default => "business"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "asset_files", :force => true do |t|
    t.string   "type"
    t.string   "asset_file_name"
    t.string   "asset_content_type"
    t.integer  "asset_file_size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "asset_files_mobile_campaigns", :id => false, :force => true do |t|
    t.integer "mobile_campaign_id"
    t.integer "asset_file_id"
  end

  add_index "asset_files_mobile_campaigns", ["mobile_campaign_id", "asset_file_id"], :name => "index_mobile_campaign_id_and_asset_file_id"

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
    t.integer  "account_id"
    t.integer  "user_id"
  end

  add_index "bar_codes", ["account_id"], :name => "index_bar_codes_on_account_id"
  add_index "bar_codes", ["id", "type"], :name => "index_bar_codes_on_id_and_type", :unique => true
  add_index "bar_codes", ["user_id"], :name => "index_bar_codes_on_user_id"

  create_table "campaigns", :force => true do |t|
    t.string   "title"
    t.string   "state",      :default => "unpublished"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cities", :force => true do |t|
    t.string   "name",       :limit => 36, :null => false
    t.string   "display",    :limit => 36
    t.integer  "region_id"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cities", ["country_id"], :name => "index_cities_on_country_id"
  add_index "cities", ["name", "country_id", "region_id"], :name => "index_cities_on_name_and_country_id_and_region_id"
  add_index "cities", ["name"], :name => "index_cities_on_name"
  add_index "cities", ["region_id"], :name => "index_cities_on_region_id"

  create_table "clicks", :force => true do |t|
    t.string   "ip_address",    :limit => 15,                                                    :null => false
    t.string   "referer",       :limit => 128
    t.integer  "user_agent_id",                                               :default => 1,     :null => false
    t.integer  "short_url_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "country_id"
    t.integer  "region_id"
    t.integer  "city_id"
    t.boolean  "located",                                                     :default => false
    t.decimal  "latitude",                     :precision => 10, :scale => 6
    t.decimal  "longitude",                    :precision => 10, :scale => 6
    t.integer  "like_it_id"
  end

  add_index "clicks", ["like_it_id"], :name => "index_clicks_on_like_it_id"
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

  create_table "dashboard_tails", :force => true do |t|
    t.integer  "account_id"
    t.integer  "user_id"
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.string   "transition"
    t.integer  "transition_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "dashboard_tails", ["account_id"], :name => "index_dashboard_tails_on_account_id"
  add_index "dashboard_tails", ["user_id"], :name => "index_dashboard_tails_on_user_id"

  create_table "invites", :force => true do |t|
    t.string   "email",      :null => false
    t.string   "full_name"
    t.string   "company"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "comment"
  end

  create_table "like_its", :force => true do |t|
    t.integer  "mobile_campaign_id"
    t.integer  "clicks_count"
    t.string   "tag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "like_its", ["mobile_campaign_id"], :name => "index_like_its_on_mobile_campaign_id"

  create_table "mobile_campaigns", :force => true do |t|
    t.string   "title"
    t.text     "style_model"
    t.text     "document_model"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "current_state",  :limit => 15, :default => "draft"
    t.integer  "short_url_id"
    t.integer  "account_id"
    t.integer  "user_id"
  end

  add_index "mobile_campaigns", ["account_id"], :name => "index_mobile_campaigns_on_account_id"
  add_index "mobile_campaigns", ["current_state"], :name => "index_mobile_campaigns_on_current_state"
  add_index "mobile_campaigns", ["short_url_id"], :name => "index_mobile_campaigns_on_short_url_id"
  add_index "mobile_campaigns", ["user_id"], :name => "index_mobile_campaigns_on_user_id"

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
    t.string   "origin",                                             :null => false
    t.string   "short",                                              :null => false
    t.integer  "clicks_count",                :default => 0,         :null => false
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "current_state", :limit => 15, :default => "proxied"
    t.integer  "account_id"
    t.integer  "user_id"
  end

  add_index "short_urls", ["account_id"], :name => "index_short_urls_on_account_id"
  add_index "short_urls", ["current_state"], :name => "index_short_urls_on_current_state"
  add_index "short_urls", ["short"], :name => "index_short_urls_on_short"
  add_index "short_urls", ["short"], :name => "short", :unique => true
  add_index "short_urls", ["short"], :name => "short_2", :unique => true
  add_index "short_urls", ["short"], :name => "short_3", :unique => true
  add_index "short_urls", ["user_id"], :name => "index_short_urls_on_user_id"

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

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
    t.string "ru_name"
  end

  create_table "user_agents", :force => true do |t|
    t.string   "details",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "profile"
    t.string   "x_wap_profile"
    t.integer  "mobile_id"
  end

  add_index "user_agents", ["details"], :name => "index_user_agents_on_details"
  add_index "user_agents", ["mobile_id"], :name => "index_user_agents_on_mobile_id"

  create_table "users", :force => true do |t|
    t.string   "full_name"
    t.string   "email",                              :null => false
    t.string   "crypted_password",                   :null => false
    t.string   "password_salt",                      :null => false
    t.string   "persistence_token",                  :null => false
    t.string   "single_access_token",                :null => false
    t.string   "perishable_token",                   :null => false
    t.integer  "login_count",         :default => 0, :null => false
    t.integer  "failed_login_count",  :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.string   "state"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["account_id"], :name => "index_users_on_account_id"

end
