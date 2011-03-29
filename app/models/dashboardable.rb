# encoding: utf-8
module Dashboardable
  
  autoload :Stringify, 'dashboardable/stringify'
  
  attr_accessor :transition, :transition_user
  
  TRANSITIONS = {
    
    MobileCampaign => [ 
      :page_created,
      :content_changed,
      :short_url_assigned,
      :short_url_generated,
      :page_published,
      :page_drafted,
      :page_unpublished,
    ],
    
    User => [
      :user_created,
      :user_updated,
      :user_activated,
    ],
    
    ShortUrl => [
      :shortener_created,
    ],
    
    BarCode => [
      :qr_code_created
    ]
  }
  
  
  def update_dashboard(transition, transition_user = nil)
    assert_transition_key(transition)
    self.transition, self.transition_user = transition, transition_user
  end
  
  def update_dashboard!(transition, transition_user = nil)
    update_dashboard(transition, transition_user) and self.save!
  end
  
  def dashboard_updated
    self.transition, self.transition_user = nil, nil
  end
  
  def has_transition_key?(transition)
    TRANSITIONS[TRANSITIONS.keys.find { |label| self.kind_of?(label) }].try(:include?, transition)
  end
  
  def assert_transition_key(transition)
    raise "can't assert transition message '#{transition}' for '#{self.class}' class" unless has_transition_key?(transition)
  end
  
end