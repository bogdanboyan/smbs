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

class LinkCode < BarCode
  
  include UrlModelsUtil
  
  validates_length_of   :origin, :is=> 40
  validate :prepare_and_parse_url
  
  def encode_string
    self.origin # urlto:uri without schema
  end
  
end