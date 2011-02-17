class Admin::DashboardsController < Admin::BaseController
  
  def show
    @dashboard_tails = DashboardTail.order('id DESC')
  end
  
end
