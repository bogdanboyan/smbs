#encoding: utf-8
class UserMailer < ActionMailer::Base
  
  default :from => '"Служба поддержки Yamco" <support@yam.co.ua>'
  
  
  def account_disable_notice(user)
    @user = user
    
    mail :to => @user.email, :subject => 'Внимание! Ваш аккаунт был заблокирован'
  end
  
  def account_activate_notice(user)
    @user = user
    
    mail :to => @user.email, :subject => 'Ваш аккаунт активирован и открыт для доступа'
  end
  
  def account_activation_instructions(to_user, from_user = nil)
    @to_user, @from_user = to_user, from_user
    @user_activation_url = edit_user_activation_url(@to_user.perishable_token)
    
    # email body logged in base64 mode
    puts @user_activation_url if Rails.env == 'development'
    mail :to => @to_user.email, :subject => '%s: Начало работы с Yamco' % from_user.try(:full_name) || from_user.try(:account).try(:title) || "Коллектив Yamco"
  end
  
  def password_reset_instructions(user)
    @user = user
    @password_reset_url = edit_password_reset_url(@user.perishable_token)
    
    # email body logged in base64 mode
    puts @password_reset_url if Rails.env == 'development'
    mail :to => @user.email, :subject => 'Инструкция по пользовательского восстановлению пароля'
  end
end
