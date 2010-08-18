require File.dirname(__FILE__) + '/../spec_helper'

describe ShortenersRedirectApp do
  
  context 'routing context' do

    %w[/campaigns /campaigns/10 /shorteners /statistics/20 /barcodes /ds].each do |path|
      it "should not process #{path} path" do
          path.should match(ShortenersRedirectApp::APPLICATION_ROUTE)
          response = ShortenersRedirectApp.call({'PATH_INFO' => path})
          response[0].should == 404
      end
    end
    
    it 'should redirect short link' do
      short_url = ShortUrl.create(:origin => 'http://ya.ru', :short => '1qZ')
      
      response = ShortenersRedirectApp.call({
        'PATH_INFO'       => "/#{short_url.short}",
        'REMOTE_ADDR'     => "127.0.0.1",
        'HTTP_USER_AGENT' => "rspec-rails"
      })
      
      response[0].should             == 301
      response[1]['Location'].should == short_url.origin
    end
    
  end
end