# encoding: utf-8
module Dashboardable
  
  attr_accessor :transition
  
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
    ]
  }
  
  
  def update_dashboard(transition)
    assert_transition_key(transition)
    self.transition = transition
  end
  
  def update_dashboard!(transition)
    update_dashboard(transition) and self.save!
  end
  
  def has_transition_key?(transition)
    TRANSITIONS[self.class].try(:include?, transition)
  end
  
  def assert_transition_key(transition)
    raise "can't assert transition message '#{transition}' for '#{self.class}' class" unless has_transition_key?(transition)
  end
  
end