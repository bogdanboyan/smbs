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

class LinkCode < BarCode
  
  include Validations::Url
  
  validates_length_of   :origin, :in=> 4..48
  validate :prepare_and_parse_url
  
  def encode_string
    self.origin
  end
  
end