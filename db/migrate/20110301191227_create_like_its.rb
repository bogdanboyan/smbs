class CreateLikeIts < ActiveRecord::Migration
  def self.up
    create_table :like_its do |t|
      t.integer :mobile_campaign_id
      t.integer :clicks_count
      t.string  :tag
      t.timestamps
    end
    
    add_index :like_its, :mobile_campaign_id
    
    add_column :clicks, :like_it_id, :integer
    
    add_index :clicks, :like_it_id
  end

  def self.down
    remove_column :like_its, :mobile_campaign_id
    remove_column :like_its, :clicks_count
    remove_column :like_its, :tag
    
    remove_index :like_its, :mobile_campaign_id
    
    drop_table :like_its
    
    remove_column :clicks, :like_it_id
  end
end