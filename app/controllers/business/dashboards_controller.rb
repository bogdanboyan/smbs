class Business::DashboardsController < Business::BaseController
  
  before_filter :load_dashboard_tails
  
  
  def more_activity
    @dashboard_tails.map! { |tail| render_to_string(:partial => 'dashboard_tail.html', :object => tail) }
    render :json => { html: @dashboard_tails.join(' ') }
  end
  
  private
  
  def load_dashboard_tails
    @dashboard_tails = DashboardTail.where([ "account_id = ?", current_account.id ])
      .order('id DESC')
      .paginate(:page => params[:page], :per_page => 15)
  end
  
end
