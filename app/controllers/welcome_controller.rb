class WelcomeController < ApplicationController
  
  def redirect
    if @short_url = ShortUrl.find_by_short(params[:short])
      click = build_clicks_attributes and build_location_for(click)
      @short_url.clicks.create(click)
      # make redirection
      redirect_to @short_url.origin, :status=> 301
    else
      render :show
    end
  end
  
  private
  
    def build_clicks_attributes
      click = {:ip_address=> request.remote_ip, :referer=> request.referer}
      click[:user_agent] = UserAgent.find_or_create_by_details(request.user_agent) unless request.user_agent.blank?
      return click
    end
    
    def build_location_for(click)
      IpLocation.find_location_for(click)
    end
end
