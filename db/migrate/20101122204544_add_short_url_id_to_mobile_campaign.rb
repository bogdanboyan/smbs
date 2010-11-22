class AddShortUrlIdToMobileCampaign < ActiveRecord::Migration
  def self.up
    add_column :mobile_campaigns, :short_url_id, :integer
  end

  def self.down
    remove_column :mobile_campaigns, :short_url_id
  end
end
