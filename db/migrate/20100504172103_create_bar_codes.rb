class CreateBarCodes < ActiveRecord::Migration
  def self.up
    create_table :bar_codes do |t|
      t.string :type,                         :null=> false
      t.string :origin
      t.string :tel
      t.string :text
      t.column :source, :mediumtext
      t.integer :version
      t.string  :level
      t.timestamps
    end
    add_index :bar_codes, [:id, :type], :unique => true
  end

  def self.down
    remove_index :bar_codes, :column => [:id, :type]
    drop_table :bar_codes
  end
end
