class AssignEntitiesToAccount < ActiveRecord::Migration
  def self.up
    add_column :short_urls, :account_id, :integer
    add_index  :short_urls, :account_id
    
    add_column :mobile_campaigns, :account_id, :integer
    add_index  :mobile_campaigns, :account_id
    
    add_column :bar_codes, :account_id, :integer
    add_index  :bar_codes, :account_id
  end

  def self.down
  end
end
