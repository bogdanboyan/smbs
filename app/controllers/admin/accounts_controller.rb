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
  
  
  private
  
  def load_account
    @account = Account.find params[:id]
  end
end
