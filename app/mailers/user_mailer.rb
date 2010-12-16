#encoding: utf-8
class UserMailer < ActionMailer::Base
  
  default :from => 'Служба поддержки Yamco <support@yam.co.ua>'
  
  
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
    
    # email body logged in base64 mode
    puts @password_reset_url if Rails.env == 'development'
    mail :to => @user.email, :subject => 'Инструкция по пользовательского восстановлению пароля'
  end
end
