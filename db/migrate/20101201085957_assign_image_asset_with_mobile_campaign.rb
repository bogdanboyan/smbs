class AssignImageAssetWithMobileCampaign < ActiveRecord::Migration
  def self.up
    MobileCampaign.all.each do |campaign|
      puts "1. Assign assets for mobile_campaign(%d) '%s'" % [campaign.id, campaign.title]
      campaign.map_document_model_images
      puts '2. mobile_campaign.asset_files(%s)' % campaign.asset_files.inspect
    end
  end

  def self.down
  end
end
