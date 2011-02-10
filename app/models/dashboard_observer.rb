class DashboardObserver < ActiveRecord::Observer
  
  observe :mobile_campaign, :short_url
  
  def after_save(record)
    if record.send(:kind_of?, Dashboardable) && record.try(:transition)
      # log tail
      Rails.logger.info "observe: #{record}"
    end
  end
  
end
