class CreateSummarizedClicks < ActiveRecord::Migration
  def self.up
    create_table :summarized_clicks do |t|
      t.integer :clicks,      :null=>false
      t.integer :city_id
      t.integer :country_id
      t.integer :region_id
      t.integer :short_url_id,:null=>false
      t.string  :percent,     :null=>false
      t.date    :date,        :null=>false
      t.timestamps
    end
    
    add_index :summarized_clicks, :short_url_id
    add_index :summarized_clicks, [:short_url_id, :date]
    
  end

  def self.down
    remove_index :summarized_clicks, :short_url_id
    remove_index :summarized_clicks, [:short_url_id, :date]
    drop_table :summarized_clicks
  end
end
