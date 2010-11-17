# == Schema Info
#
# Table name: short_urls
#
#  id           :integer(4)      not null, primary key
#  campaign_id  :integer(4)
#  clicks_count :integer(4)      not null, default(0)
#  description  :text
#  origin       :string(255)     not null
#  short        :string(255)     not null
#  title        :string(255)
#  created_at   :datetime
#  updated_at   :datetime

class ShortUrl < ActiveRecord::Base

  include Validations::Url

  has_many   :clicks
  belongs_to :campaign

  validate :prepare_and_parse_url

  scope :unbound, where(:campaign_id => nil)
  
  # init final state machine
  include AASM
  
  aasm_column :current_state
  aasm_initial_state :proxied
  
  aasm_state :proxied
  aasm_state :pending
  
  aasm_event :enable do
    transitions :to => :proxied, :from => [:pending]
  end
  
  aasm_event :disable do
    transitions :to => :pending, :from => [:proxied]
  end
  
  
  def short_url(request)
    "#{request.domain}/#{self.short}"
  end
  
  def has_clicks?
    self.clicks_count > 0
  end
  
end
