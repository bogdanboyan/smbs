module Admin::DashboardHelper
  
  def admin_dashboard_items_filter_link(title, distance_of_time)
    select_date = distance_of_time.to_date.to_s
    if params[:select_date] == select_date
      title
    else
      link_to title, admin_dashboard_url(:select_date => select_date), :class => 'button white'
    end
  end
  
end