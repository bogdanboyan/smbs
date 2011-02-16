class AddUserIdToShortUrls < ActiveRecord::Migration
  def self.up
    add_column :short_urls, :user_id, :integer
    add_index :short_urls, :user_id
    
    # remove old stuff
    remove_column :short_urls, :campaign_id
  end

  def self.down
    remove_index :short_urls, :user_id
    remove_column :short_urls, :user_id
  end
end