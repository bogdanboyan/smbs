# encoding: utf-8
class UserSession < Authlogic::Session::Base
  # Set expiration for cookie authentication
  remember_me_for 3.months

  # Enable secure (login|email)/password validation
  generalize_credentials_error_messages "Такой почтовый адрес не зарегистрирован, либо пароль неверный"

end
