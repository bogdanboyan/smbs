class AddDetailsIntexToUserAgents < ActiveRecord::Migration
  def self.up
    add_index :user_agents, :details
  end

  def self.down
    remove_index :user_agents, :details
  end
end