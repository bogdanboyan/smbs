class AddMobileCampaignsAssetFiles < ActiveRecord::Migration
  def self.up
    remove_column :asset_files, :mobile_campaign_id
    
    create_table :asset_files_mobile_campaigns, :id => false, :force => true do |table|
      table.integer :mobile_campaign_id
      table.integer :asset_file_id
    end
    
    add_index :asset_files_mobile_campaigns, [:mobile_campaign_id, :asset_file_id], :name => 'index_mobile_campaign_id_and_asset_file_id'
  end

  def self.down
    drop_table :asset_files_mobile_campaigns
  end
end
