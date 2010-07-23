# == Schema Info
#
# Table name: campaigns
#
#  id         :integer(4)      not null, primary key
#  state      :string(255)     default("unpublished")
#  title      :string(255)
#  created_at :datetime
#  updated_at :datetime

class Campaign < ActiveRecord::Base
  
  has_one :short_url
  has_one :bar_code
  
  
  def published?
    state == 'published'
  end
  
  def unpublished?
    state == 'unpublished'
  end
  
  def title
    read_attribute(:title) || "Без названия #{Time.now.to_date.to_s(:simple)}"
  end
  
end
