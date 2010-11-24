# encoding: utf-8
module ShortenersHelper
  
  def short_url_title(model)
    "ссылка на: %s  [ %s ]" % [model.origin, model.short]
  end
  
  def short_url_title_with_origin_link_pair(model)
    "#{model.short_url(request)} &rarr; ".html_safe + link_to("#{truncate(model.origin, :length => 40)}", model.origin, :class=> 'title', :target=> '_blank')
  end
  
end