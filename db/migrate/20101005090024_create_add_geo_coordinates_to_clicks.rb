class CreateAddGeoCoordinatesToClicks < ActiveRecord::Migration
  def self.up
    add_column :clicks, :latitude,  :decimal, :precision => 10, :scale => 6
    add_column :clicks, :longitude, :decimal, :precision => 10, :scale => 6
  end

  def self.down
    remove_column :clicks, :latitude
    remove_column :clicks, :longitude
  end
end
