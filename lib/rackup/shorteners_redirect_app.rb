# encoding: utf-8
require 'ip_location'

module Rackup
  class ShortenersRedirectApp < ActionController::Metal
    
    def redirect
      if short_url = ShortUrl.find_by_short(params[:short])
        
        if short_url.proxied?
          click = build_clicks_params(env) and click = update_location_for(Click.new(click))
          short_url.clicks << click
          location = short_url.origin
        end
        
        if short_url.pending?
          location = url_for(:shortener_is_pending_url)
        end
      end
      
      set_headers :status => 302, :response_body => 'Redirecting...', :location => (location || url_for(:shortener_not_found_url))
    end


    private
    
    def url_for(named_route)
      @@url_map ||= {
        :shortener_not_found_url  => '/mobi/shorteners/not-found',
        :shortener_is_pending_url => '/mobi/shorteners/pending'
      }.freeze
      
      env['HTTP_HOST'] + @@url_map[named_route]
    end
    
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