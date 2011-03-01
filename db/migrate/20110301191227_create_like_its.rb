class CreateLikeIts < ActiveRecord::Migration
  def self.up
    create_table :like_its do |t|
      t.integer :mobile_campaign_id
      t.integer :clicks_cache
      t.string  :label
      t.timestamps
    end
    
    add_index :like_its, :mobile_campaign_id
    
    add_column :clicks, :like_it_id, :integer
    
    add_index :clicks, :like_it_id
  end

  def self.down
    remove_column :clicks, :like_it_id
    remove_column :clicks, :click
    remove_column :cl, :column_name
    remove_index :like_its, :mobile_campaign_id
    drop_table :like_its
  end
end