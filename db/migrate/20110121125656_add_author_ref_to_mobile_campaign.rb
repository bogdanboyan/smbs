class AddAuthorRefToMobileCampaign < ActiveRecord::Migration
  def self.up
    add_column :mobile_campaigns, :user_id, :integer
    add_index  :mobile_campaigns, :user_id
    
    MobileCampaign.all.each do |mbc|
      if first_user = mbc.account.users.first
        mbc.update_attribute(:user_id, first_user.id)
      end
    end
  end

  def self.down
    remove_column :mobile_campaigns, :user_id
    remove_index :mobile_campaigns, :user_id
  end
end