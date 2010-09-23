class CreateFileAssets < ActiveRecord::Migration
  def self.up
    create_table :asset_files do |t|
      t.string  :type,    :require => true
      t.integer :page_id, :require => true
      
      t.string  :asset_file_name
      t.string  :asset_content_type
      t.integer :asset_file_size
      
      t.timestamps
    end
  end

  def self.down
    drop_table :asset_files
  end
end
