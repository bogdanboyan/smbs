#encoding: utf-8
class Admin::UsersController < Admin::BaseController
  
  before_filter :load_account
  before_filter :load_account_user, :except => [ :index, :new, :create ]
  
  respond_to :html


  # Fix rails unknown issue
  # A ActiveRecord::RecordNotFound occurred in users#new:
  # Couldn't find User without an ID
  # activerecord (3.0.3) lib/active_record/relation/finder_methods.rb:279:in `find_with_ids'
  def new; end

  def index
    @users = @account.users
  end
  
  def create
    @user = User.new(params[:user].merge(:account => @account))
    @user.generate_random_password
    
    if @user.save
      @user.invite!
      flash[:notice] = "Письмо активации аккаунта было отправлено по адресу '%s'" % @user.email
    end
    respond_with @user, :location => admin_account_users_path(@account)
  end
  
  def update
    if @user.update_attributes params[:user]
      flash[:notice] = "Пользователь с логином '%s' успешно изменен" % @user.email
    end
    respond_with @user, :location => admin_account_users_path(@account)
  end
  
  def invite
    if @user.pending? || @user.invited?
      @user.invite!
      flash[:notice] = "Приглашение было повторно отправлено на адрес '%s'" % @user.email
    end
    
    redirect_to settings_admin_account_path(@account)
  end
  
  def activate
    if @user.pending?
      @user.activate!
      flash[:notice] = "Пользователь '%s' был успешно активирован" % @user.email
    else
      flash[:error] = "Пользователь '%s' уже заблокирован и не может заблокироваться снова" % @user.email
    end
    
    redirect_to settings_admin_account_path(@account)
  end
  
  def disable
    if @user.activated?
      @user.disable!
      flash[:notice] = "Пользователь '%s' был заблокирован" % @user.email
    else
      flash[:error] = "Пользователь '%s' уже активирован и не может активироваться повторно" % @user.email
    end
    
    redirect_to settings_admin_account_path(@account)
  end


  protected
  
  def load_account
    @account = Account.find params[:account_id]
  end
  
  def load_account_user
    @user = @account.users.find params[:id]
  end
end
