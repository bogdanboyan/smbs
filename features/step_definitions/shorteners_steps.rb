# encoding: utf-8
Допустим /^пользователь уже создал Short адрес:$/ do |таблица|
  @short_urls = []
  таблица.hashes.each do |row|
    @short_urls << ShortUrl.create(row)
  end
  @short_url = @short_urls.try(:first)
  Account.first.short_urls = @short_urls
end


Тогда /^список созданых мною Short адресов:$/ do |таблица|
  has_css?('.history')
  таблица.hashes.each do |row|
    within('.history') do
      body.should include(row['origin'])
      body.should include(ShortUrl.find_by_origin(row['origin']).short)
      body.should include(row['clicks_count'])
    end
  end
end


Тогда /^я должен увидеть Short адрес:$/ do |table|
  has_css?('.history')
  within('.history') do
    short_url = ShortUrl.find_by_origin(table.rows_hash['origin'])
    body.should include(short_url.origin)
  end
end


Тогда /^я должен увидеть Short адрес \(созданый от имени "([^\"]*)" пользователя\):$/ do |email, table|
  has_css?('.history')
  within('.history') do
    short_url = ShortUrl.find_by_origin(table.rows_hash['origin'])
    short_url.user.email.should == email
    body.should include(short_url.origin)
  end
end


Тогда /^количество переходов по короткому адресу "([^\"]*)" должно быть "([^\"]*)"$/ do |short, count|
  short_url = ShortUrl.where(:short => short).first
  short_url.clicks_count.should == count.to_i if count.to_i > 0
end


Тогда /^Short адрес посетили такие пользователи:$/ do |таблица|
  @clicks = []
  таблица.hashes.each do |row|
    @clicks << Click.create(row.merge(:short_url => @short_url, :created_at => 2.days.ago))
  end
end


Допустим /^я не перехожу по ссылкам перенаправления$/ do
  driver = page.driver
  def driver.follow_redirects!
   false
  end
end


Тогда /^мой запрос должен быть перенаправлен на адрес "([^\"]*)"$/ do |адрес|
  page.status_code.should == 302
  page.response_headers['Location'].should include(адрес)
end


Тогда /^я должен получить ошибку "([^\"]*)"$/ do |код|
  page.status_code.should == код.to_i
end
