require 'spec_helper'
require 'rack/mock'

describe Rackup::AnalyticDataSourceApp do
  
  DATA_SOURCES = [
    '/ds/shortener/98/clicks',
    '/ds/shortener/98/regions'
  ]
  
  UNKNOWN_DATA_SOURCES = [
    'ds/shortener/98',
    'campaigns/100',
  ]
  
  context 'routing context' do

     DATA_SOURCES.each do |path|

      it "should process #{path} request" do
        req = Rack::Request.new(Rack::MockRequest.env_for("#{path}?tqx=reqId:10"))

        response = Rackup::AnalyticDataSourceApp.call(req.env)
        response[0].should == 200
      end
    end
    
     UNKNOWN_DATA_SOURCES.each do |path|
       
      it "should not process #{path} request" do
        req = Rack::Request.new(Rack::MockRequest.env_for("#{path}?tqx=reqId:10"))

        response = Rackup::AnalyticDataSourceApp.call(req.env)
        response[0].should == 404
      end
    end
      
  end

end
