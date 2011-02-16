class Admin::DashboardsController < Admin::BaseController
  
  def show
    @dashboard_tails = DashboardTail.all
  end
  
end
