class Click < ActiveRecord::Base

  belongs_to :short_url, :counter_cache => true
  belongs_to :like_it, :counter_cache => true
  belongs_to :user_agent
  belongs_to :country
  belongs_to :region
  belongs_to :city

end
