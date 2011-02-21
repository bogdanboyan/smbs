class Business::DashboardsController < Business::BaseController
  
  def show
    @dashboard_tails = DashboardTail.where(
      [ "account_id = ?", current_account.id ]
    ).order('id DESC')
  end
  
end
