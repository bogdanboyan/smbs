# encoding: utf-8

Допустим /^пользователь уже создал Short адрес:$/ do |таблица|
  @short_urls = []
  таблица.hashes.each do |row|
    @short_urls << ShortUrl.create(row)
  end
  @short_url = @short_urls.try(:first)
end

Тогда /^список созданых мною Short адресов:$/ do |таблица|
  has_css?('.history')
  таблица.hashes.each do |row|
    within('.history') do
      body.should include(row['origin'])
      body.should(include(ShortUrl.find_by_origin(row['origin']).short))
      body.should include(row['clicks_count'])
    end
  end
end

Тогда /^я должен увидеть Short адрес:$/ do |список|
  has_css?('.history')
  row = список.rows_hash
  within('.history') do
    short_url = ShortUrl.find_by_origin(row['origin'])
    body.should include(short_url.origin)
  end
end

Тогда /^система должна зарегистрировать мой переход$/ do
  short_url = @short_urls.first.reload
  short_url.clicks_count.should == 1
  short_url.clicks.size.should  == 1
  short_url.clicks.first.ip_address.should == '127.0.0.1'
end

Тогда /^Short адрес посетили такие пользователи:$/ do |таблица|
  @clicks = []
  таблица.hashes.each do |row|
    @clicks << Click.create(row.merge(:short_url => @short_url, :created_at => 2.days.ago))
  end
end

Тогда /^система не должна регистрировать этот запрос$/ do
  short_url = @short_urls.first.reload
  short_url.clicks_count.should == 0
end

Тогда /^мой запрос должен быть перенаправлен на адрес "([^\"]*)"$/ do |адрес|
  page.status_code == 301
  page.response_headers['Location'] == адрес
end

Тогда /^я должен получить ошибку "([^\"]*)"$/ do |код|
  page.status_code == код.to_i
end
