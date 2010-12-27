#encoding: utf-8
class Mobile::CampaignsController < ApplicationController
  
  before_filter :require_current_user
  
  before_filter :load_mobile_camapign, :only => [:settings, :edit, :update, :destroy, :assign_short_url, :generate_short_url]
  
  def index
    @campaigns  = current_account.mobile_campaigns.where("current_state = 'draft' OR current_state = 'published'").order('created_at DESC')
  end
  
  def edit
    @images = @campaign.asset_files.only_images
  end
  
  def create
    campaign = MobileCampaign.new(params[:mbc])
    is_saved = campaign.save and campaign.map_document_model_images and current_account.mobile_campaigns << campaign
    
    render :json => { :mbc_id => campaign.id, :success => !!is_saved, :error => campaign.errors.full_messages.first }
  end
  
  def update
    is_updated = @campaign.update_attributes(params[:mbc]) and @campaign.map_document_model_images
    
    render :json => { :mbc_id => @campaign.id, :success => !!is_updated, :error => @campaign.errors.full_messages.first }
  end
  
  def destroy
    @campaign.archive!
    redirect_to mobile_campaigns_path
  end
  
  def assign_short_url
    if params[:short_url].match(/\/(\w+)$/) && short_url = ShortUrl.find_by_short($1)
      short_url.origin    = mobile_app_campaign_url(@campaign)
      
      @campaign.short_url = short_url
      @campaign.save!
      
      flash[:notice] = "Короткий адрес '/#{short_url.short}' был добавлен к мобильной странице"
    else
      flash[:error]  = "Не верный формат короткого адреса - задайте полный URL"
    end
    
    redirect_to settings_mobile_campaign_url(@campaign)
  end
  
  def ids_with_images
    render :json => { :ids => MobileCampaign.all.delete_if {|i| i.asset_files.only_images.empty? }.map(&:id) }
  end
  
  def generate_short_url
    @campaign.short_url = ShortUrl.generate mobile_app_campaign_url(@campaign)
    @campaign.save!
    
    flash[:notice] = "Короткий адрес '/#{@campaign.short_url.short}' был добавлен к мобильной странице"
  
    redirect_to settings_mobile_campaign_url(@campaign)
  end


  private
  
  def load_mobile_camapign
    @campaign = current_account.mobile_campaigns.find params[:id]
  end
end
