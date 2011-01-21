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
    MobileCampaignMailer.publish_notice(@mobile_campaign).deliver
    
    redirect_to :back, :notice => "Страница '#{@mobile_campaign.title}' была опубликована"
  end
  
  def cancel
    @mobile_campaign.cancel_response!
    MobileCampaignMailer.cancel_response_notice(@mobile_campaign).deliver
    
    redirect_to :back, :notice => "Странице '#{@mobile_campaign.title}' было отказано в публикации"
  end
    
  def unpublish
    @mobile_campaign.unpublish!
    MobileCampaignMailer.unpublish_notice(@mobile_campaign).deliver
    
    redirect_to :back, :notice => "Страница '#{@mobile_campaign.title}' была cнята с публикации"
  end
  
  def archive
    @mobile_campaign.archive!
    redirect_to :back, :notice => "Страница '#{@mobile_campaign.title}' была помещена в архив"
  end
  
  
  private
  
  def load_mobile_campaign
    @mobile_campaign = MobileCampaign.find params[:id]
  end
end
