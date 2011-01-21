#encoding: utf-8
class MobileCampaignMailer < ActionMailer::Base
  
  default :from => '"Служба поддержки Yamco" <support@yam.co.ua>'
  
  
  def publish_notice(mobile_campaign)
    @user, @title  = fetch_info(mobile_campaign)
    
    @settings_url       = settings_mobile_campaign_url(mobile_campaign)
    @mobile_preview_url = mobile_app_campaign_url(mobile_campaign)
    @shortener_url      = mobile_campaign.short_url.link
    
    mail :to => @user.email, :subject => "Мобильная страница '#{@title}' была Опубликована"
  end
  
  def cancel_response_notice(mobile_campaign)
    @user, @title = fetch_info(mobile_campaign)
    
    @edit_url           = edit_mobile_campaign_url(mobile_campaign)
    
    mail :to => @user.email, :subject => "Мобильной странице '#{@title}' было Отказано в публикации"
  end
  
  def unpublish_notice(mobile_campaign)
    @user, @title = fetch_info(mobile_campaign)
    
    mail :to => @user.email, :subject => "Мобильная страница '#{@title}' была Снята с Публикована"
  end
  
  
  private
  
  def fetch_info(mobile_campaign)
    [ mobile_campaign.user, mobile_campaign.title.truncate(30) ]
  end
end
