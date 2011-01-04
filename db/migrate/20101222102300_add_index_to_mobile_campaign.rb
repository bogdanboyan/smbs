class AddIndexToMobileCampaign < ActiveRecord::Migration
  def self.up
    add_index :mobile_campaigns, :short_url_id
  end

  def self.down
    remove_index :mobile_campaigns, :short_url_id
  end
end