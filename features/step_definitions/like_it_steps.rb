# encoding: utf-8

Допустим /^существует LikeIt кнопка:$/ do |table|
  @like_its = []
  
  table.hashes.each { |row| @like_its << LikeIt.create(row) }
  
  @like_it = @like_its.first
end

Тогда /^система должна зарегистрировать мой переход для LikeIt кнопки "([^\"]*)"$/ do |tag|
  like_it = LikeIt.find_by_tag tag

  like_it.clicks_count.should == 1
  like_it.clicks.size.should  == 1
  like_it.clicks.first.ip_address.should == '127.0.0.1'
end

Тогда /^система не должна регистрировать этот запрос LikeIt кнопки "([^\"]*)"$/ do |tag|
  like_it = LikeIt.find_by_tag tag
  
  like_it.clicks_count.should be_nil
  like_it.clicks.size.should  == 0
end
