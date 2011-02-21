class Admin::DashboardsController < Admin::BaseController
  
  before_filter :load_dashboard_tails
  
  
  def more_activity
    @dashboard_tails.map! { |tail| render_to_string(:partial => 'dashboard_tail.html', :object => tail) }
    render :json => { html: @dashboard_tails.join(' ') }
  end
  
  
  private
  
  def load_dashboard_tails
    params[:select_date] ||= 0.day.ago.to_date.to_s
    
    @dashboard_tails = DashboardTail.where(["DATE(created_at) = ?", params[:select_date]])
      .order('id DESC')
      .paginate(:page => params[:page], :per_page => 30)
  end
  
end
