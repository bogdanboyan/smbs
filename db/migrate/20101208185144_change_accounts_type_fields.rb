class ChangeAccountsTypeFields < ActiveRecord::Migration
  def self.up
    rename_column :accounts, :type, :kind_of
  end

  def self.down
  end
end
