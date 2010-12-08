#encoding: utf-8
class SessionsController < ApplicationController
  
  def create
    @user_session = UserSession.new params[:user_session]
    if success = @user_session.save
     redirect_to account_type_home
    else
     render :action => :new
    end
  end

  def destroy
    current_user_session.destroy if current_user_session
    redirect_to root_url
  end
  
  
  private
  
  def account_type_home
    kind_of = @user_session.user.account.kind_of
    
    case kind_of
    when 'yamco' then admin_dashboard_url
    else
      raise "can't find '%s' account type home page " % kind_of
    end
  end

end
