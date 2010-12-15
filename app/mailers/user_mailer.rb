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
  
  def password_reset_instructions(user)
    @user = user
    @password_reset_url = edit_password_reset_url(@user.perishable_token)
    
    puts @password_reset_url
    
    mail :to => @user.email, :subject => 'Инструкция по восстановлению пароля'
  end
end
