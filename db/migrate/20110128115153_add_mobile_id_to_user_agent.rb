class AddMobileIdToUserAgent < ActiveRecord::Migration
  def self.up
    add_column :user_agents, :mobile_id, :integer
    add_index :user_agents, :mobile_id
  end

  def self.down
    remove_index :user_agents, :mobile_id
    remove_column :user_agents, :mobile_id
  end
end