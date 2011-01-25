# == Schema Info
#
# Table name: cities
#
#  id         :integer(4)      not null, primary key
#  country_id :integer(4)      not null
#  region_id  :integer(4)      not null
#  display    :string(36)
#  name       :string(36)      not null
#  created_at :datetime
#  updated_at :datetime

class City < ActiveRecord::Base
  
  belongs_to :country
  belongs_to :region
  
  has_many :clicks
end