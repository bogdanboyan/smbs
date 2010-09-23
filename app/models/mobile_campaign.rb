# == Schema Info
#
# Table name: mobile_campaigns
#
#  id             :integer(4)      not null, primary key
#  document_model :text
#  style_model    :text
#  title          :string(255)
#  created_at     :datetime
#  updated_at     :datetime

class MobileCampaign < ActiveRecord::Base
end