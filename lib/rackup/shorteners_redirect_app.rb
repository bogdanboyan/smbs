# encoding: utf-8
require 'ip_location'

module Rackup
  class ShortenersRedirectApp < ActionController::Metal

    def redirect
      if @short_url = ShortUrl.find_by_short(params[:short])
        click = build_clicks_params(env) and click = update_location_for(Click.new(click))
        @short_url.clicks << click

        set_headers :status => 301, :response_body => 'Ваш запрос будет перенаправлен', :location => @short_url.origin
      else
        set_headers :status => 404, :response_body => 'Запрашиваем ресурс не найден'
      end
    end


    private
    
    def set_headers(options)
      options.each { |k,v| self.send k.to_s+'=', v }
    end

    def build_clicks_params(env)
      click = {}
      click[:ip_address] = env['HTTP_X_REAL_IP'] || env['REMOTE_ADDR']
      click[:referer]    = env['HTTP_REFERER']
      click[:user_agent] = UserAgent.find_or_create_by_details(env['HTTP_USER_AGENT']) unless env['HTTP_USER_AGENT'].blank?
      click
    end

    def update_location_for(click)
      IpLocation.resolve_location_for(click)
    end
      
  end # end class
end