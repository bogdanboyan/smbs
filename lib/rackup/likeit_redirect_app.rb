#encoding: utf-8
module Rackup
  class LikeitRedirectApp < AbstractClickableApp
    
    def capture
      
      if LikeIt.exists?(params[:id]) and like_it = LikeIt.find(params[:id])
        click = build_clicks_params(env) and click = update_location_for(Click.new(click))
        like_it.clicks << click
        
        if like_it.mobile_campaign 
          location = url_for(:mobile_app_campaign_path).sub(':id', like_it.mobile_campaign.id.to_s)
        else
          location = env['HTTP_REFERER']
        end
      end
      
      location ||= mobile_app_root_path
      
      set_headers :status => 302, :response_body => 'Redirecting...', :location => location
    end
    
  end
end