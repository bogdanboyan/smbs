class CreateMobiles < ActiveRecord::Migration
  def self.up
    create_table :mobiles do |t|
      t.string :manufacturer
      t.string :model, :unique => true
      t.string :resolution
      t.integer :width,  :default => 0
      t.integer :height, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :mobiles
  end
end
