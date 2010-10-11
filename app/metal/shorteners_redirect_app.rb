# encoding: utf-8
# Allow the metal piece to run in isolation
require(File.dirname(__FILE__) + "/../../config/environment") unless defined?(Rails)
require 'ip_location'

class ShortenersRedirectApp

  APPLICATION_ROUTE = /^(\/)?(campaign|shortener|statistic|barcode|ds|mobile)/

  def self.call(env)
    if not (env['PATH_INFO'] =~ APPLICATION_ROUTE) and (@short_url = ShortUrl.find_by_short(env['PATH_INFO'].delete('/')))

      click = build_clicks_params(env) and click = @short_url.clicks.create(click)
      update_location_for(click)

      return [301, {"Content-Type" => "text/html", "Location" => @short_url.origin}, ["Ваш запрос будет перенаправлен"]]
    end

    [404, {"Content-Type" => "text/html"}, ["Not Found"]]
  end

  private

    def self.build_clicks_params(env)
      click = {:ip_address=> env['REMOTE_ADDR'], :referer=> env['HTTP_REFERER']}
      click[:user_agent] = UserAgent.find_or_create_by_details(env['HTTP_USER_AGENT']) unless env['HTTP_USER_AGENT'].blank?
      return click
    end

    def self.update_location_for(click)
      IpLocation.resolve_location_for(click)
    end

end
