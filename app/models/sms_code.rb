# == Schema Info
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

class SmsCode < BarCode
  
  validates_presence_of :tel
  validates_format_of   :tel, :with=> /\+[0-9]+/
  validates_length_of   :tel,  :is=> 13
  validates_length_of   :text, :in=> 1..60, :allow_blank=> true
  
  def encode_string
    "SMSTO:#{tel}" + (text ? ":"+text : "")
  end
end