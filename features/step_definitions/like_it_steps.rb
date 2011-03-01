# encoding: utf-8

Допустим /^существует LikeIt кнопка:$/ do |таблица|
  @like_its = []
  таблица.hashes.each do |row|
    @like_its << LikeIt.create(row)
  end
  
  MobileCampaign.first.like_its = @like_its
end
