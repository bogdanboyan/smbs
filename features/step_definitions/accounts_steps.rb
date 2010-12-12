# encoding: utf-8

Допустим /^существует аккаунт типа "([^\"]*)"$/ do |kind_of|
  Допустим %Q(существует "activated" аккаунт типа "#{kind_of}")
end

Допустим /^существует "([^\"]*)" аккаунт типа "([^\"]*)"$/ do |state, kind_of|
  @account = Account.create :state => state, :kind_of => kind_of, :title => kind_of.camelize
end

Допустим /^пользователь "([^\"]*)" c паролем "([^\"]*)"$/ do |email, password|
  Допустим %Q("activated" пользователь "#{email}" c паролем "#{password}")
end

Допустим /^"([^\"]*)" пользователь "([^\"]*)" c паролем "([^\"]*)"$/ do |state, email, password|
  @user = User.create :state => state, :email => email, :password => password, :password_confirmation => password
  @account.users << @user
end