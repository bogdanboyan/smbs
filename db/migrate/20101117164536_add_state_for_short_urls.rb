class AddStateForShortUrls < ActiveRecord::Migration
  def self.up
    add_column :short_urls, :current_state, :string, :limit => 15, :default => 'proxied'
    add_index :short_urls, :current_state
  end

  def self.down
    remove_column :short_urls, :current_state
    remove_index :short_urls, :current_state
  end
end
