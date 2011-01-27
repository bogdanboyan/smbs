require 'nokogiri'
require 'escape_utils'

module Analytic
  module Mobile
    
    class UserAgentDetector
      
      class << self
      
        def parse(opts)
          yamdex_api_opts = opts.each { |k,v| opts[k] = EscapeUtils.escape_uri(v) }.to_query
          yandex_api_url = "http://phd.yandex.net/detect?" + yandex_api_opts
          
          doc = Nokogiri::XML get(yandex_api_url).body
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