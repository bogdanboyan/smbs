class RemoveConstrainsFromCities < ActiveRecord::Migration
  def self.up
    change_column :cities, :region_id, :integer, :null => true
    change_column :cities, :country_id, :integer, :null => true
  end

  def self.down
    change_column :cities, :region_id, :integer, :null => false
    change_column :cities, :country_id, :integer, :null => false
  end
end