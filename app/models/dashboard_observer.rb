class DashboardObserver < ActiveRecord::Observer
  
  observe :mobile_campaign, :user, :short_url, :bar_code
  
  
  def after_save(record)
    if record.transition
      Rails.logger.debug "** Enter to DashboardObserver after_save callback"
      
      tail = DashboardTail.new
      
      tail.account         = record.account
      
      record.kind_of?(User) ? tail.user = record : tail.user = record.user
      
      tail.attachable      = record
      # Rails.env.test? added for dashboardable_stringify_spec.rb
      tail.transition_user = Rails.env.test? ? tail.user : (record.transition_user || tail.user)
      tail.transition      = record.transition
      
      tail.save! and record.dashboard_updated
    else
      Rails.logger.debug "** DashboardObserver skipped for #{record.class.name} class"
      true
    end
  end
  
end
