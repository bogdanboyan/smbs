# encoding: utf-8
module ShortenersHelper
  
  def short_url_title(model)
    "ссылка на: %s  [ %s ]" % [model.origin, model.short]
  end
  
  def short_url_title_with_origin_link_pair(model)
    "#{model.short_url} &rarr; ".html_safe + link_to("#{truncate(model.origin, :length => 40)}", model.origin, :class=> 'title', :target=> '_blank')
  end
  
  def link_to_origin_or_mobile_campaign(short_url)
    if mobile_campaign = short_url.mobile_campaign
      link_to truncate(mobile_campaign.title), settings_mobile_campaign_path(mobile_campaign), :class => 'title'
    else
      link_to truncate(short_url.origin, :length => 40), short_url.origin, :class=> 'title', :target=> '_blank'
    end
  end
  
end