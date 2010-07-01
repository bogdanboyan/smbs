# == Schema Info
#
# Table name: bar_codes
#
#  id          :integer(4)      not null, primary key
#  campaign_id :integer(4)
#  level       :string(255)
#  origin      :string(255)
#  source      :text(16777215)
#  tel         :string(255)
#  text        :string(255)
#  type        :string(255)     not null
#  version     :integer(4)
#  created_at  :datetime
#  updated_at  :datetime

class BarCode < ActiveRecord::Base
  
  belongs_to :campaign
  
  before_save  :encode_code_source
  after_create :save_image_boundle


  def encode_code_source
    BarbyBarcode.encode_svg(self)
  end
  
  def save_image_boundle
    BarbyBarcode.encode_png_boundles(self)
  end
end
