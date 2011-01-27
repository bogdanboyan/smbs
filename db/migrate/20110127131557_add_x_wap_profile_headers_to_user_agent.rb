class AddXWapProfileHeadersToUserAgent < ActiveRecord::Migration
  def self.up
    add_column :user_agents, :profile, :string
    add_column :user_agents, :x_wap_profile, :string
  end

  def self.down
    remove_column :user_agents, :x_wap_profile
    remove_column :user_agents, :profile
  end
end