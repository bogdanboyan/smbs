include ActionView::Helpers::SanitizeHelper::ClassMethods, ActionView::Helpers::SanitizeHelper
include CampaignsHelper, BarcodesHelper, ShortenersHelper

То /^когда я выбираю адрес "([^\"]*)" из списка$/ do |урл|
  shortener = ShortUrl.find_by_origin("http://#{урл}")
  raise "Короткий адрес: %s не найден" % урл unless shortener
  click_link strip_tags(element_title(shortener))
end

То /^когда я выбираю код "([^\"]*)" из списка$/ do |урл|
  code = LinkCode.find_by_origin("http://#{урл}")
  raise "Код для адреса: %s не найден" % урл unless code
  click_link strip_tags(element_title(code))
end

То /^я должен увидеть список ранее созданых Short адресов$/ do
  page.has_css?('div#shorteners_list')
end

То /^я должен увидеть список ранее созданых QR кодов$/ do
  page.has_css?('div#barcodes_list')
end

Допустим /^пользователь уже создал ранее рекламные компании:$/ do |таблица|
  таблица.hashes.each do |row|
    campaign = Campaign.create(:title => row['title'])
    short_url = ShortUrl.find_by_origin(row['short_url_origin'])
    bar_code  = BarCode.find_by_text(row['qr_code_text']) # customize this options
    [short_url, bar_code].each do |entity|
      entity.update_attribute(:campaign_id, campaign.id)
    end
  end
end
