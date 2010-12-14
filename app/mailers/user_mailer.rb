#encoding: utf-8
class UserMailer < ActionMailer::Base
  
  default :from => 'Служба поддержки Yamco <smbs.app@gmail.com>'
  
  
  def account_disable_notice(user)
    @user = user
    mail :to => @user.email, :subject => 'Внимание! Ваш аккаунт был заблокирован'
  end
  
  def account_activate_notice(user)
    @user = user
    mail :to => @user.email, :subject => 'Ваш аккаунт активирован и открыт для доступа'
  end
end
