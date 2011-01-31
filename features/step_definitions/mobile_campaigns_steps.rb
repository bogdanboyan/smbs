# encoding: utf-8

Допустим /^(?:|пользователь|бизнес) уже создал Mobile Campaign под названием "([^\"]*)"$/ do |идентификатор|
  @mobile_campaign  = Factory.create(идентификатор.to_s)
end

Допустим /^я должен увидеть в списке Mobile Campaign типа "([^"]*)"$/ do |factory_name|
  pending # express the regexp above with the code you wish you had
end

Тогда /^я должен увидеть Mobile Campaign страницу "([^"]*)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end
