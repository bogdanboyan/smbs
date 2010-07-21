class CampaignsController < ApplicationController
  
  def index
     @campaigns = Campaign.find(:all, :order=> 'id DESC')
  end
  
  def new
     @bar_codes = BarCode.find(:all, :order=> 'id DESC', :limit=> 10)
     @short_urls = ShortUrl.find(:all, :order=> 'id DESC', :limit=> 10)
  end
  
  def create
    if params[:campaign].length >= 3
    else
      flash[:notice] = "Для создания компании нужно задать: Мобильный сайт или Короткий адрес и QR код"
      redirect_to :action=> 'new'
    end
  end
  
end
