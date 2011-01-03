require 'shortener'

class ShortUrl < ActiveRecord::Base

  include Validations::Url

  belongs_to :account

  has_many   :clicks
  has_one    :mobile_campaign

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
  
  class << self
    
    def generate(origin_url)
      short_url       = ShortUrl.new(:origin => origin_url)
      short_url.short = Shortener.get_basemade_value(ShortSequence.create.id)
      short_url.save!
      short_url
    end
  end
  
  def short_url
    # http://yamco.mobi/A1a
    'http://%s/%s' % [ Global.host_mobi, short ]
  end
  alias :link :short_url
  
  def has_clicks?
    self.clicks_count > 0
  end
  
end
