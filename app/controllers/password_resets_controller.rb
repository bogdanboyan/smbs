#encoding: utf-8

class PasswordResetsController < ApplicationController
  
  before_filter :require_no_user, :except => [ :update ]
  before_filter :load_user_using_perishable_token, :only => [ :edit, :update ]

  respond_to :html


  def create
    if @user = User.find_by_email(params[:user][:email])
      @user.reset_perishable_token!
      UserMailer.password_reset_instructions(@user).deliver
      
      render :action => :instructions
    else
      flash[:notice] = 'По указанному почтовому адресу не числится ни один аккаунт'
      render :action => :new
    end
  end
  
  def update
    @user.require_non_blank_passwords = true
    @user.password                    = params[:user][:password]
    @user.password_confirmation       = params[:user][:password_confirmation]

    if @user.save
      flash[:notice] = "Пароль был успешно изменен."
      # AuthLogic automatically create session on success
      current_user_session.destroy
    end

    respond_with @user, :location => login_url
  end


  protected
  
  def load_user_using_perishable_token
    unless @user = User.find_using_perishable_token(params[:id])
      redirect_to login_url, :notice => 'Невозможно найти аккаунт пользователя по заданному ключу'
    end
  end
  
end
