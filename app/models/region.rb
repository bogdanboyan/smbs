# == Schema Info
#
# Table name: regions
#
#  id         :integer(4)      not null, primary key
#  country_id :integer(4)      not null
#  code       :string(255)     not null
#  display    :string(36)
#  name       :string(36)
#  created_at :datetime
#  updated_at :datetime

class Region < ActiveRecord::Base
  
  belongs_to :country
  has_many   :cities
end