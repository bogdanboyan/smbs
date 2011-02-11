module Dashboardable
  
  attr_accessor :transition
  
  TRANSITION_LIST = {
    MobileCampaign => [ 
      :page_created,
      :content_changed,
      :short_url_assigned,
      :short_url_generated,
      :page_published,
      :page_drafted,
      :page_unpublished,
    ],
    
    Account => [
      :user_added,
      :user_removed,
    ]
  }
  
  
  def update_dashboard(transition)
    assert_transition_key(transition)
    self.transition = transition
  end
  
  def has_transition_key?(transition)
    TRANSITION_LIST[self.class].try(:include?, transition)
  end
  
  def assert_transition_key(transition)
    raise "can't assert transition message '#{transition}' for '#{self.class}' class" unless has_transition_key?(transition)
  end
end