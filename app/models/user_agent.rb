class UserAgent < ActiveRecord::Base
  
  belongs_to :mobile
  
  has_many :clicks
end
