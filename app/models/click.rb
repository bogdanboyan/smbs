# == Schema Info
#
# Table name: clicks
#
#  id            :integer(4)      not null, primary key
#  city_id       :integer(4)
#  country_id    :integer(4)
#  region_id     :integer(4)
#  short_url_id  :integer(4)      not null
#  user_agent_id :integer(4)      not null, default(1)
#  ip_address    :string(15)      not null
#  latitude      :float(10)
#  located       :boolean(1)
#  longitude     :float(10)
#  referer       :string(128)
#  created_at    :datetime
#  updated_at    :datetime

class Click < ActiveRecord::Base

  belongs_to :short_url, :counter_cache=> true
  belongs_to :user_agent
  belongs_to :country
  belongs_to :region
  belongs_to :city

end
