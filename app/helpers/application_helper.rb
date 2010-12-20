module ApplicationHelper
  
  def logged_user_session
    return @logged_user_session if defined?(@logged_user_session)
    @logged_user_session = UserSession.find
  end
  
  
  def real_current_account
    return @real_current_account if defined?(@real_current_account)
    @real_current_account = real_current_user.try(:account)
  end
  
  def current_account
    return @current_account if defined?(@current_account)
    @current_account = current_user.try(:account)
  end
  
  def real_current_user
    return @real_current_user if defined?(@real_current_user)
    @real_current_user = logged_user_session.try(:user)
  end
  
  def current_user
    return @current_user if defined?(@current_user)
    
    if real_current_user.account.is?(:yamco) && session[:pretend_account_short_id]
      @current_user = Account.find(session[:pretend_account_short_id]).users.first # TODO use owner as current_user
    else
      @current_user = logged_user_session.try(:user)
    end
  end
  
  
  def pretends?(given_user = nil)
    real_current_user != (given_user || current_user)
  end
  
  
  def account_dashboard_url(given_user_or_account = nil)
    
    kind_of = case given_user_or_account
    when Account then given_user_or_account.kind_of
    when User    then given_user_or_account.account.kind_of
    else
      current_user.account.kind_of
    end
    
    case kind_of
    when 'yamco'    then admin_dashboard_url
    when 'reseller' then reseller_dashboard_url
    when 'business' then business_dashboard_url
    else
      raise "can't find account_dashboard_url for '%s' account" % kind_of
    end
  end
  
  def is_current?(given_user_or_account)
    case given_user_or_account
      when User    then current_user    == given_user_or_account
      when Account then current_account == given_user_or_account
    end
  end
  
end