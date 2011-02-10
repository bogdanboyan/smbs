class DashboardObserver < ActiveRecord::Observer
  
  observe :mobile_campaign, :short_url
  
  def after_save(record)
    Rails.logger.info "observe: #{record}"
  end
  
end
