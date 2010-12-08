#encoding: utf-8
class ApplicationController < ActionController::Base

  protect_from_forgery

  helper_method :current_user_session, :current_user

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
  
  def require_user
    unless current_user
      flash[:notice] = "Вы должны войти в систему для доступа к этой странице"
      
      redirect_to login_url
      return false
    end
  end

  def require_no_user
    if current_user
      flash[:notice] = "Вы не должны быть автозирированы для доступа к этой странице"
      
      redirect_to root_url
      return false
    end
  end
  
end
