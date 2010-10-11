# encoding: utf-8
class CampaignsController < ApplicationController
  
  def index
     @campaigns = Campaign.where(:order=> 'id DESC')
  end
  
  def new
     #entities ready for campaign - unbound
     @bar_codes =  BarCode.unbound.where(:order=> 'id DESC', :limit=> 10)
     @short_urls = ShortUrl.unbound.where(:order=> 'id DESC', :limit=> 10)
  end
  
  def show
    @campaign = Campaign.find(params[:id])
  end
  
  def create
    p params.class.name
    if is_ready_to_save
      # assert no_campaign state is unbound
      bar_code  = BarCode.unbound.find(params[:selected_bar_code_element])
      short_url = ShortUrl.unbound.find(params[:selected_short_url_element])
      if bar_code and short_url
        ActiveRecord::Base.transaction do
          if campaign = Campaign.create(params[:campaign])
            [bar_code, short_url].each { |entity| entity.update_attribute(:campaign_id, campaign.id) }
            pass_redirect_to :index, "Компания '#{campaign.title}' была успешно создана"
          end
        end
      else
        pass_redirect_to :new, "Выбраные сущности не отвечают правилам создания компании"
      end
    else
      pass_redirect_to :new, "Для создания компании нужно задать: Мобильный сайт или Короткий адрес и QR код"
    end
  end


  private
  
    def is_ready_to_save
      params[:campaign].length == 2 and not params[:selected_bar_code_element].empty? and not params[:selected_short_url_element].empty?
    end
    
    def pass_redirect_to(action = 'new', msg = nil)
      flash[:notice] = msg and redirect_to :action => action.to_s
    end
  
end
