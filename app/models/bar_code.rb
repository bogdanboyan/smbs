# == Schema Info
# Schema version: 20100512175856
#
# Table name: bar_codes
#
#  id         :integer(4)      not null, primary key
#  level      :string(255)
#  origin     :string(255)
#  source     :text(16777215)
#  tel        :string(255)
#  text       :string(255)
#  type       :string(255)     not null
#  version    :integer(4)
#  created_at :datetime
#  updated_at :datetime

require 'barby'
require 'barby/outputter/svg_outputter'

class BarCode < ActiveRecord::Base
  
  before_save :encode_image
  
  def encode_image
    qr = Barby::QrCode.new(encode_string)
    self.source = qr.to_svg # which difference for image ouputters: png | image_magic | svg
    self.level = qr.level.to_s.upcase
    self.version = qr.size
  end
end
