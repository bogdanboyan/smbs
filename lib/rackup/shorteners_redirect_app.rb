# encoding: utf-8
require 'ip_location'

module Rackup
  class ShortenersRedirectApp

    APPLICATION_ROUTE = /^(\/)?(campaign|shortener|statistic|barcode|ds|mobile)/
    
    class << self

      def call(env)
        if @short_url = ShortUrl.find_by_short(env['PATH_INFO'].delete('/'))

          click = build_clicks_params(env) and click = @short_url.clicks.create(click)
          update_location_for(click)

          return [301, {"Content-Type" => "text/html", "Location" => @short_url.origin}, ["Ваш запрос будет перенаправлен"]]
        end

        [404, {"Content-Type" => "text/html"}, ["Not Found"]]
      end

      private

      def build_clicks_params(env)
        click = {:ip_address=> env['REMOTE_ADDR'], :referer=> env['HTTP_REFERER']}
        click[:user_agent] = UserAgent.find_or_create_by_details(env['HTTP_USER_AGENT']) unless env['HTTP_USER_AGENT'].blank?
        return click
      end

      def update_location_for(click)
        IpLocation.resolve_location_for(click)
      end
      
   end # end class << self
  end # end class
end