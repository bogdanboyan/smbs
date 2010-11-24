class CreateInvites < ActiveRecord::Migration
  def self.up
    create_table :invites do |t|
      t.string :email,     :null => false
      t.string :full_name
      t.string :company
      t.string :phone
      
      t.timestamps
    end
  end

  def self.down
    drop_table :invites
  end
end
