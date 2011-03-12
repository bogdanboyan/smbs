# encoding: utf-8
module Rackup
  class ShortenersRedirectApp < AbstractClickableApp
    
    def redirect
      if short_url = ShortUrl.find_by_short(params[:short])
        
        if short_url.proxied?
          click = build_clicks_params(env) and click = update_location_for(Click.new(click))
          short_url.clicks << click
          location = short_url.origin
        end
        
        location = url_for(:is_pending_mobile_app_shorteners_path) if short_url.pending?
      end
      
      location ||= url_for(:not_found_mobile_app_shorteners_path)
      
      set_headers :status => 302, :response_body => 'Redirecting...', :location => location
    end
    
  end # end class
end