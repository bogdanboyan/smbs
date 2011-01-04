# encoding: utf-8
class Admin::MobileCampaignsController < Admin::BaseController
  
  before_filter :load_mobile_campaign, :only => [ :publish, :cancel, :unpublish, :archive ]
  
  
  def pending
    @pending_campaigns = MobileCampaign.where(:current_state => 'pending')
  end
  
  def published
    @published_campaigns = MobileCampaign.where(:current_state => 'published')
  end
  
  
  def publish
    @mobile_campaign.publish!
    redirect_to_pending_action "Страница '%s' была опубликована" % @mobile_campaign.title
  end
  
  def cancel
    @mobile_campaign.cancel_response!
    redirect_to_pending_action "Странице '%s' было отказано в публикации" % @mobile_campaign.title
  end
    
  def unpublish
    @mobile_campaign.unpublish!
    redirect_to_pending_action "Страница '%s' была cнята с публикации" % @mobile_campaign.title
  end
  
  def archive
    @mobile_campaign.archive!
    redirect_to_pending_action "Страница '%s' была помещена в архив" % @mobile_campaign.title
  end
  
  
  private
  
  def load_mobile_campaign
    @mobile_campaign = MobileCampaign.find params[:id]
  end
  
  def redirect_to_pending_action(notice)
    redirect_to :back, :notice => notice
  end
end
