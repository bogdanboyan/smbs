# encoding: utf-8
Factory.define :mobile_campaign do |t|
  t.id             1
  t.asset_files    { |i| [ i.association(:image_asset) ] }
  t.title          "Новый браузер Chrome"
  t.document_model "[{\"type\":\"header\",\"value\":\"h3. Новый быстрый браузер: теперь и для Mac!\"},{\"type\":\"text\",\"value\":\"\\\"Google Chrome\\\":http://www.google.com/chrome?hl=ru загружает веб-страницы и приложения с молниеносной скоростью.\"},{\"type\":\"images\",\"value\":[{\"width\":\"196px\",\"asset_id\":\"100\",\"style\":\"view\",\"path\":\"/assets/mobcn/100/1285524080.view.jpg?1285524080\"}]}]"
end

Factory.define :mbc_with_html_code, :class => MobileCampaign do |t|
  t.id             2
  t.title          "HTML который должен быть вырезан"
  t.document_model "[{\"type\":\"header\",\"value\":\"h1. HTML <i>теги</i>!\"},{\"type\":\"text\",\"value\":\"просто текст <div class='item'>внутри div контейнера</div>\"}]"
end

