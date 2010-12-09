#encoding: utf-8
class ApplicationController < ActionController::Base

  protect_from_forgery

  helper_method :current_user_session, :current_user, :account_home_url

  helper :all # include all helpers, all the time


  def render_200_response
    render :text => "OK", :status => 200
  end
  
  def render_404_response
    render :text => "Not found", :status => 404
  end


  protected

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end
  
  def require_yamco_user
    require_user(:yamco)
  end
  
  def require_reseller_user
    require_user(:reseller)
  end
  
  def require_business_user
    require_user(:business)
  end
  
  def require_user(kind_of = nil)
    if !current_user || (kind_of && !current_user.account.is?(kind_of))
      flash[:notice] = "Вы должны быть авторизированы для доступа к этой странице"
      
      redirect_to login_url
      return false
    end
  end

  def require_no_user
    if current_user
      redirect_to root_url
      return false
    end
  end
  
  def account_home_url(given_user = nil)
    kind_of = (current_user||given_user).account.kind_of
    
    case kind_of
    when 'yamco' then admin_dashboard_url
    else
      raise "can't find '%s' account type home page " % kind_of
    end
  end
  
end
