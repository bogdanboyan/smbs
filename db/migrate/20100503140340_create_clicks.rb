class CreateClicks < ActiveRecord::Migration
  def self.up
    create_table :clicks do |t|
      t.string    :ip_address,      :limit => 15,   :null => false
      t.string    :referer,         :limit => 128
      t.integer   :user_agent_id,   :default => 1,  :null => false
      t.integer   :short_url_id,                    :null => false
      t.timestamps
    end
    
    add_index :clicks, :short_url_id
    add_index :clicks, :user_agent_id
    add_index :clicks, [:short_url_id, :created_at]
  end

  def self.down
    drop_table :clicks
    remove_index  :clicks, :short_url_id
    remove_index  :clicks, :user_agent_id
  end
end
