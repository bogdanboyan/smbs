#encoding: utf-8
class Mobile::CampaignsController < ApplicationController
  
  before_filter :require_current_user
  
  before_filter :load_mobile_camapign, :except => [ :index, :new, :create, :ids_with_images ]
  
  
  # Q: Why rails render new.html.erb without enter load_mobile_camapign before hook if new method isn't defined??
  # A ActiveRecord::RecordNotFound occurred in users#new:
  # Couldn't find User without an ID
  # activerecord (3.0.3) lib/active_record/relation/finder_methods.rb:279:in `find_with_ids'
  def new; end
  
  def index
    @campaigns  = current_account.mobile_campaigns.where("current_state = 'draft' OR current_state = 'published'").order('updated_at DESC')
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
      short_url.account   = current_account
      short_url.save!
      
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
    short_url = ShortUrl.generate mobile_app_campaign_url(@campaign)
    short_url.account = current_account
    short_url.save!
    
    @campaign.short_url = short_url
    @campaign.save!
    
    flash[:notice] = "Короткий адрес '/#{@campaign.short_url.short}' был добавлен к мобильной странице"
    redirect_to settings_mobile_campaign_url(@campaign)
  end
  
  def approve
    if @campaign.draft?
      @campaign.request_approve!
      flash[:notice] = 'Заявка на публикацию страницы принята и будет обработана'
    end
    
    redirect_to settings_mobile_campaign_url(@campaign)
  end


  private
  
  def load_mobile_camapign
    @campaign = current_account.mobile_campaigns.find params[:id]
  end
end
