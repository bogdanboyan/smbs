class CreateShortSequences < ActiveRecord::Migration
  def self.up
    create_table :short_sequences do |t|
      t.timestamps
    end
  end

  def self.down
    drop_table :short_sequences
  end
end
