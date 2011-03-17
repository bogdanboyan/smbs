class AddCommentsToInvite < ActiveRecord::Migration
  def self.up
    add_column :invites, :comment, :string
  end

  def self.down
    remove_column :invites, :comment
  end
end