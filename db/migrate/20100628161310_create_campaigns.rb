class CreateCampaigns < ActiveRecord::Migration
  def self.up
    create_table :campaigns do |t|
      t.string :title
      t.string :state
      t.timestamps
    end
    
    add_column :short_urls, :campaign_id, :integer
    add_column :bar_codes, :campaign_id, :integer
  end

  def self.down
    remove_column :short_urls, :campaign_id
    remove_column :bar_codes, :campaign_id
    drop_table :campaigns
  end
end
