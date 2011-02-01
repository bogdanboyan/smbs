# encoding: utf-8
module Admin::MobileCampaignsHelper
  
  def campaign_short_url_link_title(instance)
    "короткий адрес: %s" % (instance.short_url.try(:link) || 'не установлен')
  end
  
  def campaign_clicks_counter(instance)
    "просмотров: %d" % (instance.short_url.try(:clicks_count) || 0)
  end
  
end
