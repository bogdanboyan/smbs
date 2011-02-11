class DashboardObserver < ActiveRecord::Observer
  
  include ApplicationHelper
  
  observe :mobile_campaign, :short_url
  
  def after_save(record)
    Rails.logger.debug "** Enter to DashboardObserver after_save callback"
    
    if record.transition
      tail = DashboardTail.new
      
      tail.account         = record.account
      tail.user            = record.user
      
      tail.attachable      = record
      tail.transition_user = current_user
      tail.transition      = record.transition
      
      tail.save!
    else
      Rails.logger.debug "** Skip DashboardObserver for instance '#{record.inspect}'"
      
      true
    end
  end
  
end
