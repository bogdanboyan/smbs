#encoding: utf-8
class Admin::UsersController < Admin::BaseController
  
  respond_to :html
  
  before_filter :load_account
  before_filter :load_user, :only => [ :edit, :update, :activate, :disable ]
  
  def index
    @users = @account.users
  end

  def create
    @user = User.new params[:user].merge(:state => :pending)
    @user.require_non_blank_passwords = false
    
    if @user.save
      UserMailer.account_activation_instructions(@user, current_user).deliver
      
      flash[:notice] = "Пользователь с логином '%s' был создан" % @user.email
      @account.users << @user
    end
    respond_with @user, :location => admin_account_users_path(@account)
  end
  
  def update
    if @user.update_attributes params[:user]
      flash[:notice] = "Пользователь с логином '%s' успешно изменен" % @user.email
    end
    respond_with @user, :location => admin_account_users_path(@account)
  end
  
  def activate
    if @user.pending?
      @user.activate!
      flash[:notice] = "Пользователь '%s' был успешно активирован" % @user.email
    else
      flash[:error] = "Пользователь '%s' уже заблокирован и не может заблокироваться снова" % @user.email
    end
    
    redirect_to edit_admin_account_user_url(@account, @user)
  end
  
  def disable
    if @user.activated?
      @user.disable!
      flash[:notice] = "Пользователь '%s' был заблокирован" % @user.email
    else
      flash[:error] = "Пользователь '%s' уже активирован и не может активироваться повторно" % @user.email
    end
    
    redirect_to edit_admin_account_user_url(@account, @user)
  end


  private
  
  def load_account
    @account = Account.find params[:account_id]
  end
  
  def load_user
    @user = @account.users.find(params[:id])
  end
  
end
