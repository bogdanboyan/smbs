class WelcomeController < ApplicationController
  
  def redirect
    if @short_url = ShortUrl.find_by_short(params[:short])
      @short_url.clicks.create(build_clicks_attributes)
      redirect_to @short_url.origin, :status=> 301
    else
      render :show
    end
  end
  
  private
  
    def build_clicks_attributes
      click = {:ip_address=> request.remote_ip, :referer=> request.referer}
      click[:user_agent] = UserAgent.find_or_create_by_details(request.user_agent) unless request.user_agent.blank?
      click
    end
end
