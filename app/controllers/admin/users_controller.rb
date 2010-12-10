#encoding: utf-8
class Admin::UsersController < Admin::BaseController
  
  respond_to :html
  
  before_filter :load_account
  before_filter :load_user, :only => [:edit, :update]
  
  def index
    @users = @account.users
  end

  def create
    @user = User.new params[:user]
    if @user.save
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


  private
  
  def load_account
    @account = Account.find params[:account_id]
  end
  
  def load_user
    @user = @account.users.find(params[:id])
  end
  
end
