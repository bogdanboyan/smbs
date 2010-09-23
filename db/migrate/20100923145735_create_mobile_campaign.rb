class CreateMobileCampaign < ActiveRecord::Migration
  def self.up
    create_table :mobile_campaigns do |t|
      t.string :title
      t.text   :style_model
      t.text   :document_model
      t.timestamps
    end
  end

  def self.down
    drop_table :mobile_campaigns
  end
end
