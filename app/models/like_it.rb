class LikeIt < ActiveRecord::Base
  
  belongs_to :mobile_campaign
  
  has_many :clicks
  
end
