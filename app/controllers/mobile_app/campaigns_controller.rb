# encoding: utf-8

class MobileApp::CampaignsController < MobileApp::BaseController
  
  helper 'mobile_app/campaigns'
  
  
  def show
    # we want receive email notification about requests for unknown campaigns ids
    if MobileCampaign.exists? params[:id]
      @mbc = MobileCampaign.find params[:id]
      
      @document_model = @mbc.document_model_as(:array).map! do |entity| 
        entity.symbolize_keys!
        def entity.is_a_partial?(type); self[:type] == type; end
        entity
      end
      
      load_see_more(@mbc)
    else
      redirect_to_not_found_page
    end
  end
end
