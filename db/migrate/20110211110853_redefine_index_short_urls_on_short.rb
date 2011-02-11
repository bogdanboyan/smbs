class RedefineIndexShortUrlsOnShort < ActiveRecord::Migration
  def self.up
    remove_index :short_urls, :short # this index is UNIQUE!
    add_index :short_urls, :short
  end

  def self.down
  end
end
