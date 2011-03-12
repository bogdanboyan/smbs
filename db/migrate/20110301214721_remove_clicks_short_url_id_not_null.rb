class RemoveClicksShortUrlIdNotNull < ActiveRecord::Migration
  def self.up
    change_column :clicks, :short_url_id, :integer, :null => true
  end

  def self.down
    change_column :clicks, :short_url_id, :integer
  end
end