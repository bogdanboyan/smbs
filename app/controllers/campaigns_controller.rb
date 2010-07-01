class CampaignsController < ApplicationController
  
  def index
     @campaigns = Campaign.find(:all, :order=> 'id DESC', :limit=> 10)
     @p_campaigns =  @campaigns.select {|c| c.published?   }
     @un_campaigns = @campaigns.select {|c| c.unpublished? }
  end
  
  def new
     @bar_codes = BarCode.find(:all, :order=> 'id DESC', :limit=> 10)
     @short_urls = ShortUrl.find(:all, :order=> 'id DESC', :limit=> 10)
  end
  
end
