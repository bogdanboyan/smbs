# encoding: utf-8
class UserSession < Authlogic::Session::Base
  
  # Set uuser credential key
  cookie_key "_y_u"
  
  # Set expiration for cookie authentication
  remember_me_for 1.week

  # Enable secure (login|email)/password validation
  generalize_credentials_error_messages "Такой почтовый адрес не зарегистрирован, либо пароль неверный"

end
