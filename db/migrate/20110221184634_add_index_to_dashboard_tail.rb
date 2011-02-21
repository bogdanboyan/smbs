class AddIndexToDashboardTail < ActiveRecord::Migration
  def self.up
    add_index :dashboard_tails, :account_id
    add_index :dashboard_tails, :user_id
  end

  def self.down
    remove_index :dashboard_tails, :user_id
    remove_index :dashboard_tails, :account_id
    mind
  end
end