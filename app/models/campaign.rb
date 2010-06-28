class Campaign < ActiveRecord::Base
  
  has_one :short_url
  has_one :bar_code
  
  
  def published?
    state == 'published'
  end
  
  def unpublished?
    state == 'unpublished'
  end
  
end
