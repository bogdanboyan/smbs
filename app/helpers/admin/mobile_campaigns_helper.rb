# encoding: utf-8
module Admin::MobileCampaignsHelper
  
  
  def campaign_title_with_shortener(instance)
    truncate(instance.title, :length => 80) + " (короткий адрес: %s)" % (instance.short_url.try(:short) || 'не установлен')
  end
end
