# encoding: utf-8

Когда /^я посылаю запрос о получении "([^\"]*)" статистики для Short адреса "([^\"]*)"$/ do |member, address|
  visit "/analytic/shortener/#{address}/#{member}.json"
end

Тогда /^я должен получить ответ "([^\"]*)" формата$/ do |type|
  page.status_code == 200
  page.response_headers['Content-type'] == type
end
