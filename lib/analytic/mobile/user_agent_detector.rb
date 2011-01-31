require 'nokogiri'
require 'escape_utils'

module Analytic
  module Mobile
    
    class UserAgentDetector
      
      class << self
      
        def parse(opts)
          yandex_api_url = "http://phd.yandex.net/detect?#{opts.to_query}"
          
          if document = Nokogiri::XML(get(yandex_api_url).body)
            
            return {} if not document.css('yandex-mobile-info-error').empty?
            
            data = {
              :manufacturer => document.css('vendor').text,
              :model        => document.css('name').text,
              :width        => document.css('screenx').text,
              :height       => document.css('screeny').text,
            }
            
            data.merge! :resolution => "#{data[:width]} x #{data[:height]}"
          end
        end
      
      
        private
      
        def get(url)
          @http_session ||=
          begin
            session = ::Patron::Session.new
            session.insecure = true
            session.connect_timeout = 10
            session.timeout = 20
            session.max_redirects = 0
            session.handle_cookies
            http_default_headers.each { |k,v| session.headers[k] = v }
 
            session
          end
          
          @http_session.get(url)
        end
        
        def http_default_headers
          {
            "User-Agent"      => "Mozilla/5.0",
            "Accept"          => "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
            "Accept-Language" => "en-us,en;q=0.7,uk;q=0.3",
            "Accept-Charset"  => "UTF-8,*",
            "Keep-Alive"      => '115',
            "Connection"      => 'keep-alive'
          }
        end
        
      end # end class << self
    end # end class UserAgentDetector
    
  end # end module Mobile
end # end module Analytic