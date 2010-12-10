#encoding: utf-8
module Admin::AccountsHelper
  
  def account_pages_title
    "Аккаунт %s" % @account.title
  end
end
