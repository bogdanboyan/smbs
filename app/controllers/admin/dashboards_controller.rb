class Admin::DashboardsController < Admin::BaseController
  
  def show
    params[:select_date] ||= 0.day.ago.to_date.to_s
    
    @dashboard_tails = DashboardTail.where(["date(created_at) = ?", params[:select_date]]).order('id DESC')
  end
  
end
