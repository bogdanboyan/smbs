# encoding: utf-8
module Admin::MobileCampaignsHelper
  
  def campaign_short_url_link_title(instance)
    "короткий адрес: %s" % (instance.short_url.try(:link) || 'не установлен')
  end
  
  def campaign_clicks_counter(instance)
    "просмотров: %d" % (instance.short_url.try(:clicks_count) || 0)
  end
  
  def admin_campaign_navigation_title(instance)
    "%s &rarr; %s %s; %s" % [
      link_to(truncate(instance.account.title, :length => 15), settings_admin_account_path(instance.account), :title => instance.account.title),
      link_to(truncate(instance.title), mobile_app_campaign_url(instance), :target => 'blank', :title => instance.title),
      campaign_clicks_counter(instance),
      campaign_short_url_link_title(instance),
    ]
  end
  
end
