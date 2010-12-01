class AssignImageAssetWithMobileCampaign < ActiveRecord::Migration
  def self.up
    MobileCampaign.all.each do |campaign|
      puts "1. Assign assets for mobile_campaign(%d) '%s'" % [campaign.id, campaign.title]
      campaign.document_model_as(:array).each do |model|
        if model['type'] == 'images'
          # look assets data
          model['value'].each do |image_model|
            if  ImageAsset.exists?(image_model['asset_id'])
              campaign.asset_files.push! ImageAsset.find(image_model['asset_id'])
              puts 'Assign asset_file(%d)' % image_model['asset_id']
            end
          end
        end
      end
      puts '2. mobile_campaign.asset_files(%s)' % campaign.asset_files.inspect
    end
  end

  def self.down
  end
end
