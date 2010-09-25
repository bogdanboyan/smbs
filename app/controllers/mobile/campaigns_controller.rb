class Mobile::CampaignsController < ApplicationController
  
  def index
    @campaigns  = MobileCampaign.all
  end
  
  def show
    @mbc = MobileCampaign.find(params[:id])
    @document_model = @mbc.document_model_as(:array).map! {|entity| entity.symbolize_keys }
    render :action => 'show', :layout => false
  end
  
  def edit
    @mbc = MobileCampaign.find(params[:id])
    @images = ImageAsset.all
  end
  
  def new
    @images = ImageAsset.all
  end
  
  def create
    mbc = MobileCampaign.new(params[:mbc])
    mbc.save ? render(:json=> {:mbc_id => mbc.id }) : render(:status => 400, :text => 'Bad Request')
  end
  
  def update
    mbc = MobileCampaign.find(params[:id])
    mbc.update_attributes(params[:mbc]) ? render(:json=> {:mbc_id => mbc.id }) : render(:status => 400, :text => 'Bad Request')
  end
  
  def destroy
    MobileCampaign.destroy(params[:id])
    redirect_to mobile_campaigns_path
  end
  
  
end
