# == Schema Info
#
# Table name: countries
#
#  id         :integer(4)      not null, primary key
#  code       :string(3)       not null
#  display    :string(36)
#  name       :string(36)      not null
#  created_at :datetime
#  updated_at :datetime

class Country < ActiveRecord::Base
  
  has_many :regions
  has_many :cities
end