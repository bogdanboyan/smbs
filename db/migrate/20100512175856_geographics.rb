class Geographics < ActiveRecord::Migration
  def self.up
    
    create_table :countries, :force => true do |t|
      t.string :name, :null=> false, :limit=> 36
      t.string :code, :null=> false, :limit=> 3
      t.string :display,             :limit=> 36
      t.timestamps
    end
    
    add_index :countries, :name
    add_index :countries, :code
    add_index :countries, [:name, :code]
    
    create_table :regions, :force => true do |t|
      t.string :name,                       :limit=> 36
      t.string :code,        :null=>false
      t.string :display,                    :limit=> 36
      t.integer :country_id, :null=> false
      t.timestamps
    end
    
    add_index :regions, :code
    add_index :regions, :name
    add_index :regions, :country_id
    add_index :regions, [:code, :country_id]
    
    create_table :cities, :force => true do |t|
      t.string :name, :null=> false, :limit=> 36
      t.string :display,             :limit=> 36
      t.integer :region_id, :null=> false
      t.integer :country_id, :null=> false
      t.timestamps
    end
    
    add_index :cities, :region_id
    add_index :cities, :country_id
    add_index :cities, :name
    add_index :cities, [:name, :country_id, :region_id]
    
    add_column :clicks, :country_id, :integer
    add_column :clicks, :region_id, :integer
    add_column :clicks, :city_id, :integer
    add_column :clicks, :located, :boolean, :default=> false
    
  end

  def self.down
    remove_column :clicks, :located
    remove_index :cities,  [:name, :country_id, :region_id]
    remove_index :regions, [:code, :country_id]
    remove_column :clicks, :city_id
    remove_column :clicks, :region_id
    remove_column :clicks, :country_id
    
    remove_index :countries, :code
    remove_index :countries, :name
    remove_index :countries, [:name, :code]
    
    remove_index :regions, :country_id
    remove_index :regions, :name
    remove_index :regions, :code
    
    remove_index :cities, :name
    remove_index :cities, :country_id
    remove_index :cities, :region_id
    
    drop_table :cities
    drop_table :regions
    drop_table :countries
  end
end
