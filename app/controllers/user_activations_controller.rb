#encoding: utf-8
class UserActivationsController < ApplicationController
  
  before_filter :require_no_user
  before_filter :load_user_using_perishable_token, :only => [ :edit, :update ]

  respond_to :html
  
  
  def update
    @user.require_non_blank_passwords = true
    @user.password                    = params[:user][:password]
    @user.password_confirmation       = params[:user][:password_confirmation]
    
    @user.update_dashboard(:user_activated)

    if @user.save
      flash[:notice] = "Аккаунт был успешно активирован. Теперь вы можете использовать свой email и пароль"
      @user.activate!
    end

    respond_with @user, :location => login_url
  end
  
  
  protected
  
  def load_user_using_perishable_token
    unless @user = User.find_using_perishable_token(params[:id])
      redirect_to login_url, :flash => { :error => 'Эта ссылка неверная или уже неактивна' }
    end
  end
  
end
