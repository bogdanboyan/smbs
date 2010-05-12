# == Schema Info
# Schema version: 20100512175856
#
# Table name: user_agents
#
#  id         :integer(4)      not null, primary key
#  details    :string(255)     not null
#  created_at :datetime
#  updated_at :datetime

class UserAgent < ActiveRecord::Base
  
  has_many :clicks
end
