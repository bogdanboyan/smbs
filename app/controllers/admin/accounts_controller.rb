# encoding: utf-8
class Admin::AccountsController < Admin::BaseController
  
  respond_to :html
  
  before_filter :load_account, :except => [:index, :new, :create]
  
  
  def index
    @accounts = Account.all
  end
  
  def new
    @account = Account.new
  end
  
  def create
    @account = Account.new params[:account]
    if @account.save
      flash[:notice] = "Аккаунт '%s' был создан" % @account.title
    end
    respond_with @account, :location => admin_accounts_url
  end
  
  def update
    if @account.update_attributes params[:account]
      redirect_to settings_admin_account_url(@account), :notice => "Изменения были успешно сохранены"
    else
      render :action => :settings
    end
  end
  
  def activate
    if @account.disabled?
      @account.activate!
      flash[:notice] = "Аккаунт '%s' был успешно активирован" % @account.title
    else
      flash[:error] = "Аккаунт '%s' уже заблокирован и не может заблокироваться снова" % @account.title
    end
    
    redirect_to settings_admin_account_url(@account)
  end
  
  def disable
    if @account.activated?
      @account.disable!
      flash[:notice] = "Аккаунт '%s' был заблокирован" % @account.title
    else
      flash[:error] = "Аккаунт '%s' уже активирован и не может активироваться повторно" % @account.title
    end
    
    redirect_to settings_admin_account_url(@account)
  end
  
  
  def pretend
    session[:prtd] = @account.id
    redirect_to account_dashboard_url(@account)
  end
  
  def stop_pretend
    session[:prtd] = nil
    redirect_to account_dashboard_url(real_current_account)
  end
  
  
  private
  
  def load_account
    @account = Account.find params[:id]
  end
end
