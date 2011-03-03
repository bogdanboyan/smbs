#encoding: utf-8
class SessionsController < ApplicationController
  
  before_filter :require_no_user, :only => [ :new, :create ]
  
  
  def create
    @user_session = UserSession.new params[:user_session]
    @current_user = @user_session.user if @user_session.save
    @current_user ? redirect_to(cookies[:return_to] || account_dashboard_url) :  render(:action => :new)
  end

  def destroy
    logged_user_session.try(:destroy)
    redirect_to root_url
  end
  
end
