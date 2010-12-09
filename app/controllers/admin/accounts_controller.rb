# encoding: utf-8
class Admin::AccountsController < Admin::BaseController
  
  before_filter :load_account, :except => [:index]
  
  
  def index
    @accounts = Account.all
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
