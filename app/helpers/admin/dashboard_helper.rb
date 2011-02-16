module Admin::DashboardHelper
  
  def stringify_admin_dashboard_item(tail)
    strf, vars = tail.stringify
    strf
  end
  
end
