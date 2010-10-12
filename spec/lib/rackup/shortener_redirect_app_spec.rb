require 'spec_helper'
require 'rack/test'

module Rackup
  describe ShortenersRedirectApp do
    
    include Rack::Test::Methods
    def app; Rackup::ShortenersRedirectApp; end
    
    context 'routing context' do

      %w[/campaigns /campaigns/10 /shorteners /statistics/20 /barcodes /ds /mobile].each do |path|
        it "should not process #{path} path" do
            path.should match(ShortenersRedirectApp::APPLICATION_ROUTE)
            response                = get path
            response.status.should == 404
        end
      end

      it 'should redirect short link' do
        short_url = ShortUrl.create(:origin => 'http://ya.ru', :short => '1qZ')
      
        response = get "/#{short_url.short}", {}, {
          'REMOTE_ADDR'     => "127.0.0.1",
          'HTTP_USER_AGENT' => "rspec-rails"
        }
      
        response.status.should              == 301
        response.headers['Location'].should == short_url.origin
      end
    
    end
  end
end