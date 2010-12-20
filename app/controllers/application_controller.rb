#encoding: utf-8
class ApplicationController < ActionController::Base

  include ApplicationHelper


  protect_from_forgery

  helper :all # include all helpers, all the time


  def render_200_response
    render :text => "OK", :status => 200
  end
  
  def render_404_response
    render :text => "Not found", :status => 404
  end


  protected

  def require_no_user
    redirect_to root_url if current_user
  end
  
  def require_yamco_user
    require_gituser(:yamco)
  end
  
  def require_reseller_user
    require_user(:reseller)
  end
  
  def require_business_user
    require_user(:business)
  end
  
  def require_user(kind_of = nil)
    if !current_user || (kind_of && !current_user.account.is?(kind_of))
      redirect_to login_url, :notice => "Вы должны быть авторизированы для доступа к этой странице"
    end
  end

end
