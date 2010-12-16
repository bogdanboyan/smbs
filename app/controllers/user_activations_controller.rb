#encoding: utf-8
class UserActivationsController < ApplicationController
  
  before_filter :require_no_user
  before_filter :load_user_using_perishable_token, :only => [ :edit, :update ]

  respond_to :html
  
  
  def update
    @user.require_non_blank_passwords = true
    @user.password                    = params[:user][:password]
    @user.password_confirmation       = params[:user][:password_confirmation]

    if @user.save
      flash[:notice] = "Аккаунт был успешно активирован"
      @user.activate!
    end

    respond_with @user, :location => login_url
  end
  
  
  protected
  
  def load_user_using_perishable_token
    @user = User.find_using_perishable_token params[:id]
    unless @user.try(:pending?)
      redirect_to login_url, :notice => 'Не удалось обнаружить неактивированный аккаунт пользователя'
    end
  end
  
end
