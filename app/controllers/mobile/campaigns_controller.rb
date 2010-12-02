#encoding: utf-8
class Mobile::CampaignsController < ApplicationController
  
  before_filter :load_mobile_camapign, :only => [:settings, :edit, :update, :destroy, :assign_short_url, :generate_short_url]
  
  def index
    @campaigns  = MobileCampaign.where(:current_state => 'published').order('created_at DESC')
  end
  
  def edit
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
    @campaign.update_attributes(params[:mbc]) ? render(:json=> {:mbc_id => @campaign.id }) : render(:status => 400, :text => 'Bad Request')
  end
  
  def destroy
    campaign.archive!
    redirect_to mobile_campaigns_path
  end
  
  def assign_short_url
    if params[:short_url].match(/\/(\w+)$/) && short_url = ShortUrl.find_by_short($1)
      short_url.origin    = mobile_campaign_url(@campaign)
      short_url.save!
      
      @campaign.short_url = short_url
      @campaign.save!
      
      flash[:notice] = "Короткий адрес '/#{short_url.short}' был добавлен к мобильной странице"
    else
      flash[:error]  = "Не верный формат короткого адреса - задайте полный URL"
    end
    
    redirect_to settings_mobile_campaign_url(@campaign)
  end
  
  def generate_short_url
    @campaign.short_url = ShortUrl.generate mobile_campaign_url(@campaign)
    @campaign.save!
    
    flash[:notice] = "Короткий адрес '/#{@campaign.short_url.short}' был добавлен к мобильной странице"
  
    redirect_to settings_mobile_campaign_url(@campaign)
  end


  private
  
  def load_mobile_camapign
    @campaign = MobileCampaign.find(params[:id])
  end
end
