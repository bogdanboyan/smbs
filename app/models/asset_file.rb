# root STI model
class AssetFile < ActiveRecord::Base
  
  has_and_belongs_to_many :mobile_campaigns
  
end
