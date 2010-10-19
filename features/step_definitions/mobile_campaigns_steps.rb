# encoding: utf-8

Допустим /^пользователь уже создал Mobile Campaign под названием "([^\"]*)"$/ do |идентификатор|
  @mobile_campaign  = Factory.create(идентификатор.to_s)
end
