class AddCaseSensitiveToShort < ActiveRecord::Migration
  def self.up
    remove_index :short_urls, :short
    ShortUrl.connection.execute "ALTER TABLE short_urls MODIFY COLUMN short varchar(255) COLLATE latin1_bin NOT NULL"
    add_index :short_urls, :short
  end

  def self.down
    ShortUrl.connection.execute "ALTER TABLE short_urls MODIFY COLUMN short varchar(255) COLLATE utf8_unicode_ci NOT NULL"
  end
end