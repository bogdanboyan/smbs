class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|
      t.string :title
      t.string :contact_phone
      t.string :contact_person
      t.string :address
      t.string :city
      t.string :bank_account
      t.string :state
      t.string :type, :default => 'business'
      t.timestamps
    end
  end

  def self.down
    drop_table :accounts
  end
end
