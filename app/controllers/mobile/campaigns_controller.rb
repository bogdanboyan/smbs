class Mobile::CampaignsController < ApplicationController
  
  def index
    @campaigns  = MobileCampaign.where(:current_state => 'published')
  end
  
  def settings
    @campaign = MobileCampaign.find(params[:id])
  end
  
  def edit
    @campaign = MobileCampaign.find(params[:id])
    @images = ImageAsset.all
  end
  
  def new
    @images = ImageAsset.all
  end
  
  def create
    campaign = MobileCampaign.new(params[:mbc])
    
    campaign.save ? render(:json=> {:mbc_id => campaign.id }) : render(:status => 400, :text => 'Bad Request')
  end
  
  def update
    campaign = MobileCampaign.find(params[:id])
    campaign.update_attributes(params[:mbc]) ? render(:json=> {:mbc_id => campaign.id }) : render(:status => 400, :text => 'Bad Request')
  end
  
  def destroy
    campaign = MobileCampaign.find(params[:id]) and campaign.archive!
    redirect_to mobile_campaigns_path
  end
  
end
