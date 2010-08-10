require File.dirname(__FILE__) + '/../spec_helper'

describe ShortenersRedirectApp do
  
  context 'routing context' do
    
    it 'should process only short link' do
      ['/campaign/10', '/shorteners', '/statistic/20', '/barcodes'].each do |path|
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