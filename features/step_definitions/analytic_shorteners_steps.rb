# encoding: utf-8

Когда /^я посылаю запрос о получении "([^\"]*)" статистики для Short адреса "([^\"]*)"$/ do |member, address|
  visit "/analytic/shortener/#{ShortUrl.find_by_short(address).try(:id)}/#{member}.json?tqx=reqId=1"
end

Тогда /^я должен получить ответ "([^\"]*)" формата$/ do |type|
  page.status_code.should == 200
  page.response_headers['Content-type'].should == type
  # puts page.body
end
