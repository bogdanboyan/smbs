class CreateShortUrls < ActiveRecord::Migration
  def self.up
    create_table :short_urls do |t|
      t.string  :origin, :null=> false
      t.string  :short,  :null=> false
      t.integer :clicks_count, :default=>0, :null=>false
      t.string  :title
      t.text    :description
      t.timestamps
    end
    
    add_index :short_urls, :short, :unique => true
  end

  def self.down
    drop_table :short_urls
    remove_index :short_urls, :short
  end
end
