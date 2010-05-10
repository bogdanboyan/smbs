# == Schema Info
# Schema version: 20100504172103
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

class TextCode < BarCode
  
  validates_presence_of :text
  validates_length_of   :text, :is=> 60
  
  def encode_string
    self.text
  end
end