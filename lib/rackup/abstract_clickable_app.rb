#encoding: utf-8

require 'location'

module Rackup
  class AbstractClickableApp < ActionController::Metal
    
    protected
    
    # ActionController::Metal is not recognize named routes
    def url_for(named_route)
      @@url_map ||= {
        :not_found_mobile_app_shorteners_path  => '/mobile_app/shorteners/not_found',
        :is_pending_mobile_app_shorteners_path => '/mobile_app/shorteners/is_pending'
      }.freeze
      
      "http://%s%s" % [ Global.host_mobi, @@url_map[named_route] ]
    end
    
    def mobile_app_root_path; url_for(nil); end
    
    def set_headers(options)
      options.each { |k,v| self.send k.to_s+'=', v }
    end

    def build_clicks_params(env)
      click = {}
      click[:ip_address] = env['HTTP_X_REAL_IP'] || env['REMOTE_ADDR']
      click[:referer]    = env['HTTP_REFERER']
      click[:user_agent] = find_or_create_user_agent(env) unless env['HTTP_USER_AGENT'].blank?
      click
    end

    def update_location_for(click)
      Location::IpDetector.resolve_location_for(click)
    end
    
    def find_or_create_user_agent(env)
      user_agent = UserAgent.find_or_create_by_details env['HTTP_USER_AGENT']
      
      # this implementation is FIX for existing user_agent records without HTTP_PROFILE or HTTP_X_WAP_PROFILE headers
      # TODO: add this headers to dynamic find_or_create_by_details method and remove this code
      if profile = env['HTTP_PROFILE']
        update_empty_attribute(user_agent, 'profile', profile)
      elsif x_wap_profile = env['HTTP_X_WAP_PROFILE']
        update_empty_attribute(user_agent, 'x_wap_profile', x_wap_profile)
      end
      
      user_agent
    end
    
    def update_empty_attribute(user_agent, attribute, value)
      user_agent.update_attribute(attribute, value.delete('"\'')) if not user_agent.try(attribute)
    end
    
    
  end # class AbstractClickableApp
end