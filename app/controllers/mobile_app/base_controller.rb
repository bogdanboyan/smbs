class MobileApp::BaseController < ActionController::Base
  
  layout 'mobile'
  
  helper 'mobile_app/application'
  
  
  protected
  
  def redirect_to_not_found_page
    redirect_to mobile_app_shorteners_url(:action => 'not_found')
  end
  
  def load_see_more(mbc=nil)
    except = "AND mobile_campaigns.id != #{mbc.id}" if mbc
    @see_more = MobileCampaign.where(:current_state => "published").where("mobile_campaigns.short_url_id IS NOT NULL #{except}").order("id desc").limit(3)
  end
  
end