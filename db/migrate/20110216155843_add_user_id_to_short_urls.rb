class AddUserIdToShortUrls < ActiveRecord::Migration
  def self.up
    add_column :short_urls, :user_id, :integer
    add_index :short_urls, :user_id
    
    # remove old stuff
    remove_column :short_urls, :campaign_id
    
    # migrate all short_urls without user reference
    ShortUrl.where(:user_id => nil).each do |short_url|
      short_url.update_attributes(:user => short_url.account.users.first) if short_url.account
    end
  end

  def self.down
    remove_index :short_urls, :user_id
    remove_column :short_urls, :user_id
  end
end