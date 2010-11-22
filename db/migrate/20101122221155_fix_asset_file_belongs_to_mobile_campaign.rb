class FixAssetFileBelongsToMobileCampaign < ActiveRecord::Migration

  def self.up
    rename_column :asset_files, :page_id, :mobile_campaign_id
  end

end
