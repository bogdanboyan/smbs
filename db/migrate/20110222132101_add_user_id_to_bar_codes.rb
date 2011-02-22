class AddUserIdToBarCodes < ActiveRecord::Migration
  def self.up
    add_column :bar_codes, :user_id, :integer
    add_index :bar_codes, :user_id
    remove_column :bar_codes, :campaign_id
  end

  def self.down
    remove_index :bar_codes, :user_id
    remove_column :bar_codes, :user_id
  end
end