# encoding: utf-8

Допустим /^система сбора статистики уже обработала список кликов$/ do
  ClicksAgregator.summarize_all_clicks(@short_url.id)
end