class AddStateForMobileCampaigns < ActiveRecord::Migration
  def self.up
    add_column :mobile_campaigns, :current_state, :string, :limit => 15, :default => 'published'
    add_index :mobile_campaigns, :current_state
  end

  def self.down
    remove_column :mobile_campaigns, :current_state
    remove_index :mobile_campaigns, :current_state
  end
end
