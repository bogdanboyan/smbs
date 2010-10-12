require 'spec_helper'
require 'rack/test'

describe Rackup::AnalyticDataSourceApp do
  
  include Rack::Test::Methods
  def app; Rackup::AnalyticDataSourceApp; end
  
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
        response = get "#{path}?tqx=reqId:10"
        response.status.should == 200
      end
    end
    
     UNKNOWN_DATA_SOURCES.each do |path|
       
      it "should not process #{path} request" do
        response = get "#{path}?tqx=reqId:10"
        response.status.should == 404
      end
    end
      
  end

end
