#encoding: utf-8
module Rackup
  class LikeitRedirectApp < AbstractClickableApp
    
    def capture
      
      if like_it = LikeIt.find(params[:id])
        click = build_clicks_params(env) and click = update_location_for(Click.new(click))
        like_it.clicks << click
        location = url_for(:mobile_app_campaign_path).sub(':id', like_it.mobile_campaign.id) || env['HTTP_REFERER']
      end
      
      location ||= mobile_app_root_path
      
      set_headers :status => 302, :response_body => 'Redirecting...', :location => location
    end
    
  end
end