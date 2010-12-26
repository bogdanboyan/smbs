# encoding: utf-8

class MobileApp::CampaignsController < MobileApp::BaseController
  
  helper 'mobile_app/campaigns'
  
  
  def show
    # we want receive email notification about requests for unknown campaigns ids
    # if MobileCampaign.exists? params[:id]
      @mbc = MobileCampaign.find params[:id]
      @document_model = @mbc.document_model_as(:array).map! {|entity| entity.symbolize_keys }
      @see_more = MobileCampaign.where(:current_state => "published").where("mobile_campaigns.short_url_id IS NOT NULL AND mobile_campaigns.id != #{@mbc.id}").order("id desc").limit(3)
    # else
    #   render :text => 'Страница не найдена', :status => 404
    # end
  end
end
