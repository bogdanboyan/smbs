Допустим /^пользователь уже создал Short адрес:$/ do |таблица|
  таблица.hashes.each do |row|
    ShortUrl.create(row)
  end
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