class ChangeMobileCampaignDefaultState < ActiveRecord::Migration
  def self.up
    change_column :mobile_campaigns, :current_state, :string, :limit => 15, :default => 'draft'
    MobileCampaign.all.each { |campaign| campaign.update_attribute('current_state', 'draft') }
  end

  def self.down
  end
end
