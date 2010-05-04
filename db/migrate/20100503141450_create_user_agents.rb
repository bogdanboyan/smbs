class CreateUserAgents < ActiveRecord::Migration
  def self.up
    create_table :user_agents do |t|
      t.string :details, :null=> false
      t.timestamps
    end
  end

  def self.down
    drop_table :user_agents
  end
end
