class DashboardObserver < ActiveRecord::Observer
  
  include ApplicationHelper
  
  observe :mobile_campaign, :user, :short_url
  
  
  def after_save(record)
    if record.transition
      Rails.logger.debug "** Enter to DashboardObserver after_save callback"
      
      tail = DashboardTail.new
      
      tail.account         = record.account
      
      record.kind_of?(User) ? tail.user = record : tail.user = record.user
      
      tail.attachable      = record
      # Rails.env.test? added for dashboardable_stringify_spec.rb
      tail.transition_user = Rails.env.test? ? tail.user : current_user
      tail.transition      = record.transition
      
      tail.save!
    else
      Rails.logger.debug "** Skip DashboardObserver for instance '#{record.inspect}'"
      
      true
    end
  end
  
end
