# == Schema Info
#
# Table name: summarized_clicks
#
#  id           :integer(4)      not null, primary key
#  city_id      :integer(4)
#  country_id   :integer(4)
#  region_id    :integer(4)
#  short_url_id :integer(4)      not null
#  clicks       :integer(4)      not null
#  date         :date            not null
#  percent      :string(255)     not null
#  created_at   :datetime
#  updated_at   :datetime

class SummarizedClick < ActiveRecord::Base
  
  belongs_to :short_url
  belongs_to :city
  belongs_to :region
  belongs_to :country
  
end
